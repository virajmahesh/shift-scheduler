class UserController < ActionController::Base

  def user_params
    params.permit(:email, :username, :password, :password_confirmation,
                  :city, :state, :zip_code, :phone_number)
  end

  def new
    if session.has_key? :user_id
      redirect_to '/'
    end
  end

  def create
    @user = User.create user_params
    if @user.invalid?
      flash[:error] = @user.errors.full_messages.first
      redirect_to '/signup'
    else
      session[:user_id] = @user.id
      redirect_to root_path
    end
  end

  def join_shift
    if not session.has_key? :user_id
      redirect_to '/login'
    else
      @user = User.find session[:user_id]
      @shift = Shift.find params[:id]

      VolunteerCommitment.create user: @user, shift: @shift
      flash[:notice] = 'You have been signed up for the shift'

      redirect_to shift_path @shift
    end
  end

  def leave_shift
    if not session.has_key? :user_id
      redirect_to '/login'
    else
      @user = User.find session[:user_id]
      @shift = Shift.find params[:id]
      @commitment = VolunteerCommitment.find_by user: @user, shift: @shift
      if not @commitment.nil?
        flash[:notice] = 'You have left the shift'
        @commitment.destroy
      end
      redirect_to shift_path @shift
    end
  end

end