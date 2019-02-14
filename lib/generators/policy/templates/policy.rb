<% module_namespacing do -%>
class <%= class_name %>Policy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.all
    end
  end

  def index?
    true
  end

  def show?
    true
  end

  def new?
    true
  end

  def create?
    true
  end

  def edit?
    true
  end

  def update?
    true
  end

  def destroy?
    true
  end

  def permitted_attributes
    %i[<%= attribute_names.join(' ') %>]
  end
end
<% end -%>
