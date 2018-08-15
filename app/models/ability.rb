class Ability
  include CanCan::Ability

  def initialize(user)
    if user.has_role? 'admin'
      can [:read, :create, :update, :destroy, :category], :all
    else
      can [:read, :category], :all
      can [:update, :destroy], [Comment, Review], user_id: user.id
    end
  end
end
