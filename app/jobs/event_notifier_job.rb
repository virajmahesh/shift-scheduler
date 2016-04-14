class EventNotifierJob < ActiveJob::Base
  queue_as :default

  def perform(event)
      UserActivity.create user_id: event.user.id, activity_id: UserActivity.event_time_id
      
  end
end
