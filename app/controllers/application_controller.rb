class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  def index
    @user = User.find_by id: session[:user_id]

    #Seeding db for testing purpose. DELETE IN PRODUCTION
    if not Event.exists?
      Event.create(:event_date => Time.now, :event_name => "Build a Wall", :id => 1, :user_id => 218, :description => "Make Donald Drumpf Again!", :location => "Berkeley", :candidate => "Donald Drumpf")
    end
    if not Shift.exists?
      Shift.create(:start_time => Time.now, :end_time => Time.now, :event_id => 1,:limit => 5,:has_limit => true, :role => 'Tabler')
      Shift.create(:start_time => Time.now, :end_time => Time.now, :event_id => 1,:limit => 3,:has_limit => true, :role => 'Valet')
    end
      
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
  
  def event
    @event = Event.find_by id: params[:id]

    if @event.nil?
      flash[:error] = "Event not found"
      redirect_to "/"
    end
    
    @shifts = Shift.where event_id: params[:id]
    @numFreeShifts = 0
    @num_volunteers = {}
    
    @shifts.each do |shift|
    @num_volunteers[shift.id] = VolunteerCommitment.where(shift_id: shift.id).size
    
    if shift.has_limit and @num_volunteers[shift.id] < shift.limit
      @numFreeShifts = @numFreeShifts + 1
    end
  end
end
end
