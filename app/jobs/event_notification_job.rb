class EventNotificationJob < ActiveJob::Base
  queue_as :default

  def perform(event)
    if Event.exists?(event.id) && Date.today == event.event_date.prev_day && !EventTimeActivity.exists?(:event_id => event.id)
      creator_id = event.user.id
      EventReminderMailer.notify_creator(event).deliver_now
      EventTimeActivity.create :owner_id => creator_id, :user_id => nil, :shift_id => nil, :event_id => event.id
    end
  end
end
