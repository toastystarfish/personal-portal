
class ApplicationPolicy
  attr_reader :user, :record
  # user: set to the result of calling the current_user method by Pundit
  # record: model object, whose authorization needs to be checked
  def initialize user, record
    @user   = user
    @record = record
  end

  # Default Policy Scope
  # Scopes are used in cases where you must scope content according to user
  # permission level.
  #
  # For instance imagine a blog app where you have Posts.
  # You could have a scope class that takes a basic relation for posts
  # and then from resolve returns all posts for admins and only returns
  # published posts as the default behavior for other users:
  #
  # class Scope < Scope
  #   def resolve
  #     user.admin? ? scope.all : scope.where(published: true)
  #   end
  # end
  #
  # In your controller you access the scopes by:
  # @posts = policy_scope Post
  class Scope
    attr_reader :user, :scope

    def initialize user, scope
      @user  = user
      @scope = scope
    end

    def resolve
      raise "scope#resolve method not implemented by child class"
    end
  end

  # default behavior for all controller index actions.
  # default to not allowed to all users (...or empty method)
  def index?
  end

  # default behavior for all controller new actions.
  # default to not allowed to all users (...or empty method)
  def new?
  end

  # default behavior for all controller show actions.
  # default to not allowed to all users (...or empty method)
  def show?
  end

  # default behavior for all controller edit actions.
  # default to not allowed to all users (...or empty method)
  def edit?
  end

  # default behavior for all controller update actions.
  # default to not allowed to all users (...or empty method)
  def update?
  end

  # default behavior for all controller create actions.
  # default to not allowed to all users (...or empty method)
  def create?
  end

  # default behavior for all controller destroy actions.
  # default to not allowed to all users (...or empty method)
  def destroy?
  end
end
