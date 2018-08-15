class Ability
  include CanCan::Ability

  def initialize(user)
    if user.has_role? 'admin'
      can [:read, :create, :update, :destroy], :all
    else
      can :read, :all
      can [:update, :destroy], [Comment, Review], user_id: user.id
    end
  end
end
