class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :parse_user

  def parse_user
    @user = current_user
  end

  def index
    @user = current_user
  end

end
