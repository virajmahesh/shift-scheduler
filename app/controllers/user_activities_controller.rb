class UserActivitiesController < ApplicationController
  before_action :parse_activities
  
  def user_activity_params
    params.permit(:user_id, :activity_id, :shift_id)
  end
  
  def delete
    id = params[:id]
    to_delete = UserActivity.find(id)
    if !to_delete.nil? && @user.id == to_delete.owner_id
      to_delete.destroy
    end
    redirect_to user_activity_path
    return
  end
  
  def show
    if @user.nil?
      redirect_to root_path
    end
  end
    
  def parse_activities
      @activities = UserActivity.where(owner_id: @user).order(created_at: :desc)
  end


end