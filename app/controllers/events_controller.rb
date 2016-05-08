class EventsController < ApplicationController
  before_action :parse_event  # Parse the event before all controller actions

  # Parses the current event and stores it in a controller variable
  def parse_event
    @event = Event.find_by id: params[:id]
  end

  # Returns the parameters needed to create or update an event
  def event_params
    params.require(:event).permit(:location, :start_time, :end_time, :event_name,
                                  :event_date, :candidate, :description)
  end

  # Link the event with the issues passed in
  def populate_issues
    if !@event.nil? and @event.valid? and params.has_key? :issue_ids
      params[:issue_ids].split(',').each do |issue_id|
        EventIssue.create event: @event, issue_id: issue_id
      end
    end
  end

  def new
    unless can? :create, Event
      redirect_to new_user_session_path
    end

    @method = :post
    @form_path = events_path
    @submit_button_text = 'Create Event'
  end

  # Create a new event. Checks that the user attempting to create the event is
  # authorized to do so
  def create
    if can? :create, Event
      @event = Event.create event_params.merge user: @user
      if @event.invalid?
        flash[:error] = @event.errors.full_messages.first
        render :new
      else
        populate_issues
        flash[:notice] = "#{@event.event_name} was successfully created."
        event_create_activity @event
        redirect_to event_path @event
      end
    else
      redirect_to 'public/422.html', status: :unauthorized
    end
  end

  def edit
    unless can? :update, @event
      redirect_to new_user_session_path
    end

    @method = :put
    @form_path = event_path @event
    @submit_button_text = 'Save Changes'

    gon.issues = @event.issues
    gon.event_date = @event.formatted_event_date
  end

  # Update an existing event. Checks that the user attempting to update the event
  # is authorized to do so
  def update
    if can? :update, @event
      old_date = @event.event_date
      @event.update_attributes event_params
      if old_date != @event.event_date && @event.event_date.future?
        create_event_reminder_job_for @event
        create_shift_remider_jobs_for @event
      end
      flash[:notice] = "#{@event.event_name} was successfully updated."
      redirect_to event_path(@event)
    else
      redirect_to 'public/422.html', status: :unauthorized
    end
  end


  # Delete an existing event. Checks that the user attempting to delete the event
  # is authorized to do so.
  def destroy
    if can? :destroy, @event
      @event.destroy
      flash[:notice] = "Event '#{@event.event_name}' deleted."
      redirect_to root_path
    else
      redirect_to 'public/422.html', status: :unauthorized
    end
  end

  # Create a copy of the event
  def duplicate
    if can? :create, Event and not @event.nil?
      @new_event = @event.duplicate @user
      event_create_activity @new_event

      flash[:notice] = 'Event successfully copied'
      redirect_to event_path @new_event
    else
      redirect_to new_user_session_path
    end
  end
  
  def event_create_activity event
    EventCreateMailer.notify_creator(@event).deliver_now
    EventCreateActivity.create :owner_id => event.user.id, :user_id => nil, :shift_id => nil, :event_id => event.id
    if event.event_date.future?
      create_event_reminder_job_for event
    end
  end
  
  def create_event_reminder_job_for event
    EventNotificationJob.set(wait_until: event.event_date.to_time - 1.day).perform_later event
  end
  
  def create_shift_remider_jobs_for event
    one_day_before_event = event.event_date.to_time - 1.day
    shifts = event.shifts
    shifts.each do |shift|
      shift.users.each do |user|
        ShiftNotificationJob.set(wait_until: one_day_before_event).perform_later user, shift
      end
    end
  end
  
end
