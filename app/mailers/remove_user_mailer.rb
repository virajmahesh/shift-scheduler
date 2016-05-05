class RemoveUserMailer < NotificationMailer

  def notify_user user, shift
    super
    @subject = 'You have been dropped from a volunteer shift.'
    @message = "The event creator #{@creator.username}(#{@creator.email}) dropped you"
    mail to: @user.email, subject: @subject, template_name: :remove_user_mail
  end

  def notify_creator user, shift
    super
    @subject = "You dropped #{user.username} from a volunteer shift."
    @message = "You dropped #{user.username}(#{user.email})"
    mail to: @event.user.email, subject: @subject, template_name: :remove_user_mail
  end

end