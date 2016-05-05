class JoinShiftMailer < NotificationMailer

  def notify_user user, shift
    @name = 'You'
    @subject = 'You signed up to volunteer!'

    build_email user, shift
    mail to: @user.email, subject: @subject, template_name: :join_shift_mail
  end

  def notify_creator user, shift
    @name = "#{user.username}(#{user.email})"
    @subject = "#{user.username} signed up for a shift of your event"

    build_email user, shift
    mail to: @event.user.email, subject: @subject, template_name: :join_shift_mail
  end

end