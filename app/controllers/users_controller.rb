class UsersController < ApplicationController

  # Returns the parameters needed to create or update a user
  def user_params
    params.permit(:email, :username, :password, :password_confirmation,
                  :city, :state, :zip_code, :phone_number, :skills)
  end

  # Adds the current user to the shift
  def join_shift
    @shift = Shift.find params[:id]

    unless @user.nil? or @shift.nil?
      VolunteerCommitment.create user: @user, shift: @shift
      flash[:notice] = 'You have been signed up for the shift'
      creator = @shift.user

      # TODO: This code needs to be moved out of here
      UserActivity.create user_id: creator.id, activity_type_id: UserActivity.join_shift_id, shift_id: @shift.id, event_id: @shift.event.id
      ShiftNotificationJob.set(wait_until: @shift.start_time.advance(:days => -1)).perform_later @shift, @user
      if @shift.has_limit and @shift.volunteer_commitments.length == @shift.limit
        UserActivity.create user_id: creator.id, activity_type_id: UserActivity.shift_full_id, shift_id: @shift.id, event_id: @shift.event.id
      end
    end

    redirect_to event_shift_path @shift.event, @shift
  end

  # Removes the current user from the shift
  def leave_shift
    @shift = Shift.find params[:id]
    @commitment = VolunteerCommitment.find_by user: @user, shift: @shift

    unless @commitment.nil?
      flash[:notice] = 'You have left the shift'

      # TODO: This code needs to be reformatted. Also, shouldn't this check for pending notification jobs and delete them.
      UserActivity.create user_id: @shift.user.id, activity_type_id: UserActivity.leave_shift_id, shift_id: @shift.id, event_id: @shift.event.id
      @commitment.destroy
    end
    redirect_to event_shift_path @shift.event, @shift
  end

end