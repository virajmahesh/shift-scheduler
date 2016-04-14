class EventNotificationJob < ActiveJob::Base
  queue_as :default

  def perform(event)
    UserActivity.create user_id: event.user.id, activity_type_id: UserActivity.event_time_id, event_id: event.id, shift_id: nil
  end
end
