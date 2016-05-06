class EventReminderMailer < NotificationMailer

  def notify_creator event
    @event = event
    @type = 'reminder'
    @need_creator_information = false
    @subject = 'Reminder! Your event is happening soon.'

    mail to: @event.user.email, subject: @subject, template_name: :event_reminder_mail
  end

end