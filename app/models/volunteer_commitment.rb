class VolunteerCommitment < ActiveRecord::Base
    belongs_to :user
    belongs_to :shift

    after_commit :create_notification, on: :create
    after_destroy :delete_notification, on: :destroy

    def create_notification
      creator = shift.event.user
      subject = "#{user.name} has joined shift #{shift.id}"
      body = "#{user.name} (#{user.email}) has joined shift #{shift.id}."
      creator.notify(subject, body, creator)
    end

    def delete_notification
      creator = shift.event.user
      subject = "#{user.name} has left shift #{shift.id}"
      body = "#{user.name} (#{user.email}) has left shift #{shift.id}."
      creator.notify(subject, body, creator)
    end
end
