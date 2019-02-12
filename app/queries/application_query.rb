
class ApplicationQuery
  attr_reader :scope

  def self.query_for *method_names, &block
    method_names.each {|name| define_method name, &block}
  end

  def self.model
    @model ||= const_get self.name.gsub(/Query/, '').singularize
  end

  def self.scope_for_user(user)
    scope = Pundit.policy_scope(user, model)
    new(scope: scope)
  end

  def initialize(scope: model)
    @scope = model
  end

  def model
    self.class.model
  end

  def find record_id
    scope.find record_id
  end

  def all
    scope.all
  end

  def find_by attribute_hash
    scope.find_by attribute_hash
  end
end
