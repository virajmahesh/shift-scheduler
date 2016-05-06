class EventCreateMailer < ActionMailer::Base
  default from: 'notifications@uprise.com', template_path: 'notification_mailer'

  def notify_creator event
    @event = event
    @subject = ' You have created a new event.'

    mail to: @event.user.email, subject: @subject, template_name: :event_create_mail
  end
end
