class ApplicationController < ActionController::Base

  protect_from_forgery with: :exception

  def index
    @user = User.find_by id: session[:user_id]
  end

end
