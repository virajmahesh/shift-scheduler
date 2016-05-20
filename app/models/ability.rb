class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new

    unless user.id.nil?
      can :create, Event
    end

    can :read, Event
    can [:update, :destroy, :create_shift], Event do |event|
      event.user == user || user.is_super_user?
    end

    can :read, Shift
    can [:create, :update, :destroy, :view_volunteers], Shift do |shift|
      shift.user == user || user.is_super_user?
    end
  end
end
