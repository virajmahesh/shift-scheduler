class UsersController < ApplicationController
  before_action :parse_shift

  def parse_shift
    @shift = Shift.find_by_id params[:id]
  end

  # Returns the parameters needed to create or update a user
  def user_params
    params.permit(:email, :username, :password, :password_confirmation,
                  :city, :state, :zip_code, :phone_number, :skills)
  end

  # Adds the current user to the shift
  def join_shift
    unless @user.nil? or @shift.nil? or @user.signed_up_for? @shift
      VolunteerCommitment.create user: @user, shift: @shift
      flash[:notice] = 'You have been signed up for the shift'

      JoinShiftMailer.notify_user(@user, @shift).deliver_now
      JoinShiftMailer.notify_creator(@user, @shift).deliver_now

      shift_activity_join @user, @shift
    end

    redirect_to event_shift_path @shift.event, @shift
  end

  # Removes the current user from the shift
  def leave_shift
    @commitment = VolunteerCommitment.find_by user: @user, shift: @shift

    unless @commitment.nil?
      flash[:notice] = 'You have left the shift'
      @commitment.destroy

      LeaveShiftMailer.notify_user(@user, @shift).deliver_now
      LeaveShiftMailer.notify_creator(@user, @shift).deliver_now

      shift_activity_leave @user, @shift
    end
    redirect_to event_shift_path @shift.event, @shift
  end

  def shift_activity_join user, shift
    creator_id = shift.user.id
    JoinActivity.create :owner_id => creator_id, :user_id => user.id, :shift_id => shift.id, :event_id => shift.event.id
    UserJoinActivity.create :owner_id => user.id, :user_id => nil, :shift_id => shift.id, :event_id => shift.event.id
    if shift.event.event_date.future?
      ShiftNotificationJob.set(wait_until: shift.event.event_date.to_time - 1.day).perform_later user, shift
    end
    if shift.has_limit and shift.volunteer_commitments.length == shift.limit
      ShiftFullActivity.create :owner_id => creator_id, :user_id => nil, :shift_id => shift.id, :event_id => shift.event.id
    end
  end

  def shift_activity_leave user, shift
    LeaveActivity.create :owner_id => shift.user.id, :user_id => user.id, :shift_id => shift.id, :event_id => shift.event.id
    UserLeaveActivity.create :owner_id => user.id, :user_id => nil, :shift_id => shift.id, :event_id => shift.event.id
  end

end