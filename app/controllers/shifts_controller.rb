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
    params.require(:shift).permit(:event_id, :start_time, :end_time, :role, :has_limit, :limit, :created_at, :updated_at, :description)
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
  
  def remove_user
    user_id = params[:user_id]
    if can? :remove_user, @shift
      VolunteerCommitment.destroy_all(user_id: user_id, shift_id: @shift)
      flash[:notice] = "User Removed."
      redirect_to event_shift_path @event, @shift
    else
      render file: 'public/422.html', status: :unauthorized
    end
  end
  
  def view_users
    if can? :view_users, @shift
      shift_userids = VolunteerCommitment.where(shift_id: @shift).pluck(:user_id)
      @shift_users = User.select(:id, :username).find(shift_userids)
      render 'shifts/users.html.erb'
    else
      render file: 'public/422.html', status: :unauthorized
    end
  end
end
