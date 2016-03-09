class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  def index
    #Shift.create(:id => 3,:limit => 5,:has_limit => true, :role => 'Tabler')
    @user = User.find_by id: session[:user_id]
  end
  
  def shift
    @shift = Shift.find_by id: params[:id]
    @user = User.find_by id: session[:user_id]
    @num_volunteers = VolunteerCommitment.where(shift_id: params[:id]).size
    if @shift.nil?
      flash[:error] = "Shift not found."
      redirect_to "/"
    end  
  end
  
  def shift_signUp
    @shift = Shift.find_by id: params[:id]
    @user = User.find_by id: session[:user_id]
    @num_volunteers = VolunteerCommitment.where(shift_id: params[:id]).size
    
    if @shift.has_limit and @shift.limit <= @num_volunteers
      flash[:error] = "Shift already full"
      redirect_to "/shift/"+params[:id] and return
    end
    
    if @user.nil?
      flash[:error] = "Login Required"
      redirect_to "/" and return
    end
    
    if @num_volunteers < @shift.limit and not @user.nil?
      VolunteerCommitment.create({:user_id => @user.id, :shift_id => @shift.id, :created_at => Time.now, :updated_at => Time.now})
      flash[:notice] = "You have been signed up for the shift"
      redirect_to "/shift/"+params[:id] and return
    end
    
  end
end
