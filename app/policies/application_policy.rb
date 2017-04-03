
class ApplicationPolicy
  attr_reader :user, :record
  # user: Pundit will call the current_user method in the controller to
  #       retrieve what to send into this argument
  # record: model object, whose authorization needs to be checked
  def initialize user, record
    @user   = user
    @record = record
  end

  NO_USER_ERR = "A current user was not provided with a check to permissions."

  # verify the user is present
  def verify_user
    raise Pundit::NotAuthorizedError, NO_USER_ERR unless @user
  end

  # Actions default to not letting anyone perform them

  def show?
  end

  def edit?
  end

  def update?
  end

  def create?
  end

  def destroy?
  end

  class Scope
    attr_reader :user, :scope

    def initialize user, scope
      @user  = user
      @scope = scope
    end
  end
end
