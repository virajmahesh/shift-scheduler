class UsersController < ApplicationController

  def user_params
    params.permit(:email, :username, :password, :password_confirmation,
                  :city, :state, :zip_code, :phone_number)
  end

  def join_shift
    @shift = Shift.find params[:id]

    unless @user.nil? or @shift.nil?
      VolunteerCommitment.create user: @user, shift: @shift
      flash[:notice] = 'You have been signed up for the shift'
      creator = @shift.user
      UserActivity.create user_id: creator.id, activity_type_id: UserActivity.join_shift_id, shift_id: @shift.id, event_id: @shift.event.id
      ShiftNotificationJob.set(wait_until: @shift.start_time.advance(:days => -1)).perform_later @shift, @user
      if @shift.has_limit and @shift.volunteer_commitments.length == @shift.limit
        UserActivity.create user_id: creator.id, activity_type_id: UserActivity.shift_full_id, shift_id: @shift.id, event_id: @shift.event.id
      end
    end

    redirect_to event_shift_path @shift.event, @shift
  end

  def leave_shift
    @shift = Shift.find params[:id]
    @commitment = VolunteerCommitment.find_by user: @user, shift: @shift

    unless @commitment.nil?
      flash[:notice] = 'You have left the shift'
      UserActivity.create user_id: @shift.user.id, activity_id: UserActivity.leave_shift_id, shift_id: @shift.id, event_id: @shift.event.id
      @commitment.destroy
    end
    redirect_to event_shift_path @shift.event, @shift
  end

end