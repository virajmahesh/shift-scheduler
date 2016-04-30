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
        redirect_to event_path @event

        # TODO: Clean this up by refactoring
        EventNotificationJob.set(wait_until: @event.event_date.to_time.advance(:days => -1)).perform_later @event
      end
    else
      redirect_to 'public/422.html', status: :unauthorized
    end
  end

  # Update an existing event. Checks that the user attempting to update the event
  # is authorized to do so
  def update
    if can? :update, @event
      @event.update_attributes event_params
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
end
