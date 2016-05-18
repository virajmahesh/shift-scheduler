class UserActivitiesController < ApplicationController
  before_action :parse_activities, only: [:show]
  before_action :parse_activity, only: [:delete]
  
  def user_activity_params
    params.permit(:user_id, :activity_id, :shift_id)
  end

  def parse_activity
    @activity = UserActivity.find_by_id params[:id]
  end
  
  def delete
    if !@activity.nil? and @user.id == @activity.owner_id
      @activity.destroy
    end
    redirect_to user_activity_path
  end
  
  def show
    if @user.nil?
      redirect_to root_path
    end
  end
    
  def parse_activities
    @activities = UserActivity.where(owner_id: @user).order(created_at: :desc)
    @activities.update_all read: true

    count_unread_notifications
  end


end