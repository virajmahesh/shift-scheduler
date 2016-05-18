class Users::RegistrationsController < Devise::RegistrationsController
  before_action :configure_sign_up_params, only: [:create]

  after_action :notify_users, only: [:create, :update]
  after_action :populate_skills, only: [:create]
  after_action :populate_issues, only: [:create]

  # If you have extra sign up params to permit, append them to the sanitizer.
  def configure_sign_up_params
    devise_parameter_sanitizer.permit(:sign_up, keys: [:email, :username, :city,
                                                       :state, :zip_code, :phone_number])
  end

  def parse_ids key
    if params.has_key? key
      params[key].split(',')
    else
      []
    end
  end

  def populate model, ids, field
    @user = current_user
    unless @user.nil?
      ids.each do |id|
        model.create user: @user, field => id
      end
    end
  end

  # Associate the current user with the skills they selected while signing up.
  def populate_skills
    populate UserSkill, parse_ids(:skill_ids), :skill_id
  end

  # Associate the current user with issues they selected while signing up.
  def populate_issues
    populate UserIssue, parse_ids(:issue_ids), :issue_id
  end

  def notify_users
    @user = current_user
    unless @user.nil?
      Shift.shifts_with_skills(@user.skills).each do |shift|
        unless @user.notified_about? shift
          MatchingShiftMailer.notify_user(@user, shift).deliver_now
          MatchingShiftActivity.create owner_id: @user.id, event: shift.event, shift: shift
        end
      end
    end
  end
end
