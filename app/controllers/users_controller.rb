class UsersController < ApplicationController

  # Returns the parameters needed to create or update a user
  def user_params
    params.permit(:email, :username, :password, :password_confirmation,
                  :city, :state, :zip_code, :phone_number, :skills)
  end

  # Adds the current user to the shift
  def join_shift
    @shift = Shift.find_by_id params[:id]

    unless @user.nil? or @shift.nil?
      VolunteerCommitment.create user: @user, shift: @shift
      flash[:notice] = 'You have been signed up for the shift'
      shift_activity_join @user, @shift
    end

    redirect_to event_shift_path @shift.event, @shift
  end

  # Removes the current user from the shift
  def leave_shift
    @shift = Shift.find_by_id params[:id]
    @commitment = VolunteerCommitment.find_by user: @user, shift: @shift

    unless @commitment.nil?
      flash[:notice] = 'You have left the shift'
      @commitment.destroy
      shift_activity_leave @user, @shift
    end
    redirect_to event_shift_path @shift.event, @shift
  end

  def shift_activity_join user, shift
    creator_id = shift.user.id
    JoinActivity.create :owner_id => creator_id, :user_id => user.id, :shift_id => shift.id, :event_id => shift.event.id
    ShiftNotificationJob.set(wait_until: shift.start_time.advance(:days => -1)).perform_later shift, user
    if shift.has_limit and shift.volunteer_commitments.length == shift.limit
      ShiftFullActivity.create :owner_id => creator_id, :user_id => nil, :shift_id => shift.id, :event_id => shift.event.id
    end
  end

  def shift_activity_leave user, shift
    LeaveActivity.create :owner_id => shift.user.id, :user_id => user.id, :shift_id => shift.id, :event_id => shift.event.id
  end

end