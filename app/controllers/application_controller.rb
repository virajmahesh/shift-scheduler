class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :parse_user  # Parse the user before every controller action

  # Parses the current user and stores it in a controller variable
  def parse_user
    @user = current_user
  end

  def index
    @future_events = Event.future_events
  end

end
