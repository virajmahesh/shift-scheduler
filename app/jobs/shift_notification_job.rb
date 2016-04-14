class ShiftNotificationJob < ActiveJob::Base
  queue_as :default

  def perform(shift, user)
    UserActivity.create user_id: user.id, activity_type_id: UserActivity.shift_time_id, shift_id: shift.id, event_id: shift.event.id
  end
end
