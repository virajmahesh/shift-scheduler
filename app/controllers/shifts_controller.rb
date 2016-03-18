class ShiftsController < ApplicationController
  before_action :parse_event

  def parse_event
    @event = Event.find params[:event_id]
  end

  def shift_params
    params.require(:shift).permit(:event_id, :start_time, :end_time, :role, :has_limit, :limit, :created_at, :updated_at)
  end

  def show
    @shift = Shift.find params[:id]
  end

  def new
  end

  def create
    @shift = Shift.create shift_params.merge(event: @event)
    if @shift.invalid?
      flash[:error] = shift.errors.full_messages.first
      redirect_to new_event_shift_path
    else
      flash[:notice] = "#{@shift.role} shift was successfully created."
      redirect_to event_shift_path @event, @shift
    end
  end

  def edit
    @shift = Shift.find params[:id]
  end

  def update
    @shift = Shift.find params[:id]
    @shift.update_attributes!(shift_params)
    flash[:notice] = "#{@shift.role} shift was successfully updated."
    redirect_to event_shift_path @event, @shift
  end

  def destroy
    @shift = Shift.find params[:id]

    @shift.destroy
    flash[:notice] = " '#{@shift.role}' shift deleted."
    redirect_to event_path @event
  end
  
end
