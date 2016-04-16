class EventsController < ApplicationController
  before_action :parse_event

  def parse_event
    @event = Event.find_by id: params[:id]
  end

  def event_params
    params.require(:event).permit(:location, :start_time, :end_time, :event_name, :event_date, :candidate, :description)
  end

  def create
    if can? :create, Event
      @event = Event.create event_params.merge user: @user
      if @event.invalid?
        flash[:error] = @event.errors.full_messages.first
        redirect_to new_event_path
      else
        flash[:notice] = "#{@event.event_name} was successfully created."
        redirect_to event_path @event
        EventNotificationJob.set(wait_until: @event.event_date.to_time.advance(:days => -1)).perform_later @event
      end
    else
      redirect_to 'public/422.html', status: :unauthorized
    end
  end

  def update
    if can? :update, @event
      @event.update_attributes event_params
      flash[:notice] = "#{@event.event_name} was successfully updated."
      redirect_to event_path(@event)
    else
      redirect_to 'public/422.html', status: :unauthorized
    end
  end

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
