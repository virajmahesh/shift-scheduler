class ShiftNotificationJob < ActiveJob::Base
  queue_as :default

  def perform(user, shift)
    if (VolunteerCommitment.exists?(:user_id => user.id, :shift_id => shift.id) && Date.today == shift.event.event_date.prev_day && !ShiftTimeActivity.exists?(:user_id => user.id, :shift_id => shift.id))
      ShiftTimeActivity.create :owner_id => user.id, :user_id => user.id, :shift_id => shift.id, :event_id => shift.event.id
    end
  end
end