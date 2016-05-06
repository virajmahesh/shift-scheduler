class EventNotificationJob < ActiveJob::Base
  queue_as :default

  def perform(event)
    creator_id = event.user.id
    EventReminderMailer.notify_creator(event).deliver_now
    EventTimeActivity.create :owner_id => creator_id, :user_id => nil, :shift_id => nil, :event_id => event.id
  end
end
