class EventsController < ApplicationController

  def event_params
    params.require(:event).permit(:user_id, :location, :event_name, :event_date, :candidate, :description)
  end

  def show
    @event = Event.find params[:id]
  end

  def edit
    @event = Event.find params[:id]
  end

  def create
    @event = Event.create event_params
    if @event.invalid?
      flash[:error] = @event.errors.full_messages.first
      redirect_to '/events/new'
    else
      flash[:notice] = "#{@event.event_name} was successfully created."
      redirect_to event_path @event
    end
  end

  def update
    @event = Event.find params[:id]
    @event.update_attributes event_params
    flash[:notice] = "#{@event.event_name} was successfully updated."
    redirect_to event_path(@event)
  end

  def destroy
    @event = Event.find(params[:id])
    @event.destroy
    flash[:notice] = "Event '#{@event.event_name}' deleted."
    redirect_to "/"
  end

end
