class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new

    unless user.id.nil?
      can :create, Event
    end

    can :read, Event
    can [:update, :destroy, :create_shift], Event, user: {id: user.id}

    can :read, Shift
    can [:create, :update, :destroy, :view_volunteers], Shift, user: {id: user.id}
  end
end
