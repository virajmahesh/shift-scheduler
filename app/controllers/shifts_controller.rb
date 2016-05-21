class ShiftsController < ApplicationController
  before_action :parse_event  # Parse the event before all controller actions
  before_action :parse_shift  # Parse the shift before all controller actions

  after_action :notify_users, only: [:create, :update]

  # Parses the current event and stores it in a controller variable
  def parse_event
    @event = Event.find_by_id params[:event_id]
  end

  # Parses the current shift and stores it in a controller variable
  def parse_shift
    @shift = Shift.find_by id: params[:id]
  end

  # Return the parameters needed to create or update a shift
  def shift_params
    params.require(:shift).permit(:event_id, :role, :start_time, :end_time,
                                  :has_limit, :limit, :created_at, :description)
  end

  # Return the skills that the shift creator wants to use
  def skills
    params[:skill_ids].split(',')
  end

  def new
    @form_method = :post
    @form_path = event_shifts_path @event
    @submit_button_text = 'Add Shift'

    gon.skills = Array.new
  end

  def edit
    @form_method = :put
    @form_path = event_shift_path @event, @shift
    @submit_button_text = 'Save Changes'

    gon.skills = @shift.skills
  end

  # Create a new shift. Checks that the user attempting to create the shift
  # is authorized to do so.
  def create
    if can? :create_shift, @event
      @shift = Shift.create shift_params.merge(event: @event)

      if @shift.invalid?
        flash.alert = @shift.errors.full_messages.first
        redirect_to new_event_shift_path @event
      else
        populate_skills

        flash.notice = 'Shift was successfully created'
        redirect_to event_shift_path @event, @shift
      end
    else
      redirect_to new_user_session_path
    end
  end

  # Update an existing shift. Checks that the user attempting to update the
  # shift is authorized to do so.
  def update
    if can? :update, @shift
      @shift.update_attributes shift_params

      if @shift.valid?
        populate_skills

        flash.notice = 'Shift was successfully updated'
        redirect_to event_shift_path @event, @shift
      else
        flash.alert = @shift.errors.full_messages.first
        redirect_to edit_event_shift_path @event, @shift
      end
    else
      redirect_to new_user_session_path
    end
  end

  # Delete an existing shift. Checks that the user attempting to update the shift
  # is authorized to do so,
  def destroy
    if can? :destroy, @shift
      @shift.destroy
      flash[:notice] = 'Shift deleted'
      redirect_to event_path @event
    else
      render file: 'public/422.html', status: :unauthorized
    end
  end

  def remove_user
    @volunteer = User.find_by_id params[:user_id]

    if can? :update, @shift
      flash[:notice] = 'User Removed'
      redirect_to event_shift_path @event, @shift

      VolunteerCommitment.destroy_all user: @volunteer, shift: @shift
      RemoveUserActivity.create owner_id: @user.id, user: nil, :shift_id => @shift.id, :event_id => @shift.event.id

      RemoveUserMailer.notify_user(@volunteer, @shift).deliver_now
      RemoveUserMailer.notify_creator(@volunteer, @shift).deliver_now
    else
      render file: 'public/422.html', status: :unauthorized
    end
  end

  def view_users
    if can? :view_volunteers, @shift
      shift_userids = VolunteerCommitment.where(shift_id: @shift).pluck(:user_id)
      @shift_users = User.select(:id, :username).find(shift_userids)
      render 'shifts/users.html.erb'
    else
      render file: 'public/422.html', status: :unauthorized
    end
  end

  def populate_skills
    if not @shift.nil? and params.has_key? :skill_ids
      @shift.populate_skills skills.map {|id| id.to_i}
    end
  end

  def notify_users
    unless @shift.nil?

      User.users_with_skills(@shift.skills).each do |user|
        unless user.notified_about? @shift
          MatchingShiftMailer.notify_user(user, @shift).deliver_now
          MatchingShiftActivity.create owner_id: user.id, event: @shift.event, shift: @shift
        end
      end
    end
  end

end
