class UserActivitiesController < ApplicationController
  before_action :parse_activities
  
  def user_activity_params
    params.permit(:user_id, :activity_id, :shift_id)
  end

  def parse_activities
      @activities = UserActivity.where(user_id: @user)
  end
 

end