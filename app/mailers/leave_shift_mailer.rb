class LeaveShiftMailer < NotificationMailer

  def notify_user user, shift
    @name = 'You'
    @subject = 'You dropped a shift'

    build_email user, shift
    mail to: @user.email, subject: @subject, template_name: :leave_shift_mail
  end

  def notify_creator user, shift
    @name = "#{user.username}(#{user.email})"
    @subject = "#{user.username} dropped a shift of your event"

    build_email user, shift
    mail to: @event.user.email, subject: @subject, template_name: :leave_shift_mail
  end

end