class EventNotificationJob < ActiveJob::Base
  queue_as :default

  def perform(event)
    creator_id = event.user.id
    EventTimeActivity.create :owner_id => creator_id, :user_id => creator_id, :shift_id => nil, :event_id => event.id
  end
end
