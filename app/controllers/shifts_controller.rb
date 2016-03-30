class ShiftsController < ApplicationController
  before_action :parse_event
  before_action :parse_shift

  def parse_event
    @event = Event.find params[:event_id]
  end

  def parse_shift
    @shift = Shift.find_by id: params[:id]
  end

  def shift_params
    params.require(:shift).permit(:event_id, :start_time, :end_time, :role, :has_limit, :limit, :created_at, :updated_at)
  end

  def create
    if can? :create_shift, @event
      @shift = Shift.create shift_params.merge(event: @event)
      if @shift.invalid?
        flash[:error] = @shift.errors.full_messages.first
        redirect_to new_event_shift_path
      else
        flash[:notice] = "#{@shift.role} shift was successfully created."
        redirect_to event_shift_path @event, @shift
      end
    else
      render file: 'public/422.html', status: :unauthorized
    end
  end

  def update
    if can? :update, @shift
      @shift.update_attributes shift_params
      flash[:notice] = "#{@shift.role} shift was successfully updated."
      redirect_to event_shift_path @event, @shift
    else
      render file: 'public/422.html', status: :unauthorized
    end
  end

  def destroy
    if can? :destroy, @shift
      @shift.destroy
      flash[:notice] = " '#{@shift.role}' shift deleted."
      redirect_to event_path @event
    else
      render file: 'public/422.html', status: :unauthorized
    end
  end
  
end
