class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  def index
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
    @signup = nil
    if !@user.nil?
      @signup = VolunteerCommitment.find_by user_id: @user.id, shift_id: @shift.id
    end
  end
  
  def shift_leave
    id = params[:id]
    @shift = Shift.find_by id: id
    @user = User.find_by id: session[:user_id]
    @signup = VolunteerCommitment.find_by user_id: @user.id, shift_id: @shift.id
    if !@signup
      flash[:error] = "You haven't signed up for this shift"
    else
      @signup.destroy
      flash[:notice] = "You have left the shift"
    end
    redirect_to shift_path(id) and return
    
  end
  
  def shift_signUp
    id = params[:id]
    @user = User.find_by id: session[:user_id]
    @shift = Shift.find_by id: id
    @num_volunteers = VolunteerCommitment.where(shift_id: id).size
    
    #Checking for valid limit and login
    if @shift.has_limit and @num_volunteers >= @shift.limit
      flash[:error] = "Shift already full"
      redirect_to shift_path(id) and return
    elsif @user.nil?
      flash[:error] = "Login Required"
      redirect_to "/" and return
    end
    
    @signup = VolunteerCommitment.find_by user_id: @user.id, shift_id: @shift.id
    
    #Checking if already signed up
    if @signup
      flash[:error] = "You have already signed up for the shift"
    else
      VolunteerCommitment.create({:user_id => @user.id, :shift_id => @shift.id, :created_at => Time.now, :updated_at => Time.now})
      flash[:notice] = "You have been signed up for the shift"
    end
    redirect_to shift_path(id) and return
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
