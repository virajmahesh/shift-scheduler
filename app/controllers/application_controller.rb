class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  before_action :parse_user, :count_unread_notifications

  def logged_in
    not current_user.nil? and not current_user.id.nil?
  end

  def count_unread_notifications
    if logged_in
      @notification_count = UserActivity.where(owner_id: @user.id, read: false).count
    else
      @notification_count = 0
    end

    @unread_notifications = (@notification_count != 0)
  end

  # Parses the current user and stores it in a controller variable
  def parse_user
    @user = current_user
  end

  def index
    @future_events = Event.future_events
  end

end
