class ShiftNotificationJob < ActiveJob::Base
  queue_as :default

  def perform(shift, user)
    ShiftTimeActivity.create :owner_id => user.id, :user_id => user.id, :shift_id => shift.id, :event_id => shift.event.id
  end
end