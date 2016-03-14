class ShiftsController < ApplicationController
  
  def shift_params
    params.require(:shift).permit(:event_id, :start_time, :end_time, :role, :has_limit, :limit, :created_at, :updated_at)
  end

  def show
    @shift = Shift.find params[:id]
    @user = User.find session[:user_id]
  end

  def new
    @event = Event.find params[:event_id]
  end

  def create
    @shift = Shift.create shift_params
    if @shift.invalid?
      flash[:error] = shift.errors.full_messages.first
      redirect_to new_shift_path
    else
      flash[:notice] = "#{@shift.role} shift was successfully created."
      redirect_to shift_path @shift
    end
  end

  def edit
    @shift = Shift.find params[:id]
    @event = @shift.event
  end

  def update
    @shift = Shift.find params[:id]
    @shift.update_attributes!(shift_params)
    flash[:notice] = "#{@shift.role} shift was successfully updated."
    redirect_to shift_path @shift
  end

  def destroy
    @shift = Shift.find params[:id]
    @event = @shift.event

    @shift.destroy
    flash[:notice] = " '#{@shift.role}' shift deleted."
    redirect_to event_path @event
  end
  
end
