class JoinShiftMailer < NotificationMailer

  def notify_user user, shift
    super
    @subject = 'You signed up to volunteer!'
    mail to: @user.email, subject: @subject, template_name: :join_shift_mail
  end

  def notify_creator user, shift
    super
    @subject = "#{user.username} signed up for a shift of your event"
    mail to: @event.user.email, subject: @subject, template_name: :join_shift_mail
  end

end