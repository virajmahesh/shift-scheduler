class MatchingShiftMailer < NotificationMailer

  def notify_user user, shift
    super
    @event = shift.event
    @subject = 'Your skills are needed!'

    mail to: user.email, subject: @subject, template_name: :matching_shift_mailer
  end
end
