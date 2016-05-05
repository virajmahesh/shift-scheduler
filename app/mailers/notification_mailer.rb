class NotificationMailer < ActionMailer::Base
  default from: 'notifications@uprise.com', template_path: 'notification_mailer'

  def notify_user user, shift
    build_email user, shift

    @name = 'You'
    @need_creator_information = true
  end

  def notify_creator user, shift
    build_email user, shift

    @name = "#{user.username}(#{user.email})"
    @need_creator_information = false
  end

  def build_email user, shift
    @user = user
    @shift = shift
    @event = shift.event
    @creator = shift.user

    if @shift.skills.length == 0
      @skills = 'None'
    else
      @skills = @shift.skills.map {|s| s.description}.join ', '
    end
  end
end
