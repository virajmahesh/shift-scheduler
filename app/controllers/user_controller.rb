class UserController < ActionController::Base

  def user_params
    params.permit(:email, :username, :password, :password_confirmation,
                  :city, :state, :zip_code, :phone_number)
  end

  def new
    if session.has_key? :user_id
      redirect_to '/'
    end
  end

  def create
    user = User.create user_params
    if user.invalid?
      flash[:error] = user.errors.full_messages.first
      redirect_to '/signup'
    else
      session[:user_id] = user.id
      redirect_to root_path
    end
  end

end