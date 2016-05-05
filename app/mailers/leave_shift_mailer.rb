class LeaveShiftMailer < NotificationMailer

  def notify_user user, shift
    super
    @subject = 'You dropped a shift'
    mail to: @user.email, subject: @subject, template_name: :leave_shift_mail
  end

  def notify_creator user, shift
    super
    @subject = "#{user.username} dropped a shift of your event"
    mail to: @event.user.email, subject: @subject, template_name: :leave_shift_mail
  end

end