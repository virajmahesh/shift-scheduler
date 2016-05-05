class NotificationMailer < ActionMailer::Base
  default from: 'notifications@uprise.com', template_path: 'notification_mailer'

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
