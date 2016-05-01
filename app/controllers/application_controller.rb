class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :parse_user  # Parse the user before every controller action

  # Parses the current user and stores it in a controller variable
  def parse_user
    @user = current_user
  end
  
  def index
    sort = params[:sort] || session[:sort]
    case sort
    when 'newest'
     @events = Event.order({:created_at => :desc})
    when 'most members'
      @events = Event.all.to_a.sort_by!(&:num_mems).reverse!
    when 'best match'
      #@events = Event.all.to_a.sort_by!(&:match_score)
    end
    #@events = Event.order(ordering)
  end

end
