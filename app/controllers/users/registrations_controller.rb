class Users::RegistrationsController < Devise::RegistrationsController
  before_action :configure_sign_up_params, only: [:create]
  before_action :configure_update_params, only: [:update]

  after_action :notify_users, only: [:create, :update]
  after_action :populate_skills, only: [:create, :update]
  after_action :populate_issues, only: [:create, :update]

  # If you have extra sign up params to permit, append them to the sanitizer.
  def configure_sign_up_params
    devise_parameter_sanitizer.permit(:sign_up, keys: [:email, :username, :city,
                                                       :state, :zip_code, :phone_number])
  end

  def configure_update_params
    devise_parameter_sanitizer.permit(:account_update, keys: [:email, :username, :city,
                                                       :state, :zip_code, :phone_number])
  end

  def issues
    params[:issue_ids].split(',').map {|id| id.to_i}
  end

  def skills
    params[:skill_ids].split(',').map {|id| id.to_i}
  end

  # Associate the current user with the skills they selected while signing up.
  def populate_skills
    if not current_user.nil? and params.has_key? :skill_ids
      current_user.populate_skills skills
    end
  end

  # Associate the current user with issues they selected while signing up.
  def populate_issues
    if not current_user.nil? and params.has_key? :issue_ids
      current_user.populate_issues issues
    end
  end

  def notify_users
    @user = current_user
    if not @user.nil?
      Shift.shifts_with_skills(@user.skills).each do |shift|

        if not @user.notified_about? shift
          MatchingShiftMailer.notify_user(@user, shift).deliver_now
          MatchingShiftActivity.create owner_id: @user.id, event: shift.event, shift: shift
        end

      end
    end
  end

  def create
    if params.has_key? :skill_ids
      gon.skills = Skill.where id: skills
    end
    if params.has_key? :issue_ids
      gon.issues = Issue.where id: issues
    end
    super
  end

  def update
    gon.skills = current_user.skills
    gon.issues = current_user.issues
    super
  end

  def edit
    gon.skills = current_user.skills
    gon.issues = current_user.issues
    super
  end
end
