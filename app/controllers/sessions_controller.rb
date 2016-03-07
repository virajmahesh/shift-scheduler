class SessionsController < ActionController::Base

  def new
    if session.has_key? :user_id
      redirect_to '/'
    end
  end

  def create
    login = params[:login]
    password = params[:password]

    @user = (User.find_by email: login) || (User.find_by username: login)

    if @user.nil? or !@user.authenticate password
      flash[:error] = 'Error: Invalid email/username or password'
      redirect_to '/login'
    else
      session[:user_id] = @user.id
      redirect_to '/'
    end
  end

  def destroy
    session.clear
    redirect_to '/'
  end
end