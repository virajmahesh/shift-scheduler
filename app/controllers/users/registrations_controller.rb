class Users::RegistrationsController < Devise::RegistrationsController
  before_action :configure_sign_up_params, only: [:create]
  after_action :populate_skills, only: [:create]
  after_action :populate_issues, only: [:create]

  # If you have extra sign up params to permit, append them to the sanitizer.
  def configure_sign_up_params
    devise_parameter_sanitizer.permit(:sign_up,
                                      keys: [:email, :username, :city, :state,
                                             :zip_code, :phone_number, :skills])
  end

  # Associate the current user with the skills they selected while signing up.
  def populate_skills
    @user = current_user
    if not @user.nil? and params.has_key? :skill_ids
      params[:skill_ids].split(',').each do |id|
        UserSkill.create user: @user, skill_id: id
      end
    end
  end

  # Associate the current user with issues they selected while signing up.
  def populate_issues
    @user = current_user
    if not @user.nil? and params.has_key? :issue_ids
      params[:issue_ids].split(',').each do |id|
        UserIssue.create user: @user, issue_id: id
      end
    end
  end
end
