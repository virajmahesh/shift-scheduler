class Users::RegistrationsController < Devise::RegistrationsController
  before_action :configure_sign_up_params, only: [:create]
  after_action :populate_skills, only: [:create]

  # If you have extra sign up params to permit, append them to the sanitizer.
  def configure_sign_up_params
    devise_parameter_sanitizer.permit(:sign_up,
                                      keys: [:email, :username, :city, :state,
                                             :zip_code, :phone_number, :skills])
  end

  def populate_skills
    @user = current_user
    if not @user.nil? and params.has_key? :skills
      params[:skills].split(',').each do |skill_id|
        UserSkill.create user: @user, skill_id: skill_id
      end
    end
  end
end
