class VolunteerCommitment < ActiveRecord::Base
    belongs_to :user
    belongs_to :shift

    after_commit :create_notification, on: :create
    after_destroy :delete_notification, on: :destroy

    def notify action
      creator = shift.event.user
      subject = "#{user.name} has #{action} shift #{shift.id}"
      body = "#{user.name} (#{user.email}) has #{action} shift #{shift.id}."
      creator.notify(subject, body, creator)
    end

    def create_notification
      notify :joined
    end

    def delete_notification
      notify :left
    end
end
