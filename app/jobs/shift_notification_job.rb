class ShiftNotificationJob < ActiveJob::Base
  queue_as :default

  def perform(shift)
    UserActivity.create user_id: shift.user.id, activity_id: UserActivity.shift_full_id, shift_id: @shift.id
  end
end
