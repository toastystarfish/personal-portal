
class ApplicationQuery
  attr_reader :scope

  def self.model
    @model ||= const_get self.name.gsub(/Query/, '').singularize
  end

  ##################################
  ## Start legacy code for compat ##
  ##################################
  def self.query_for *method_names, &block
    method_names.each {|name| define_method name, &block}
  end


  def self.find(id)
    model.find(id)
  end

  def self.find_by attribute_hash
    model.find_by attribute_hash
  end

  def self.all
    model.all
  end

  ##################################
  ## End legacy code for compat   ##
  ##################################

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

  def index(page, sort={})
    relation = User
    relation = relation.order(sort) unless sort.blank?
    relation.paginate page: page, per_page: 10
  end

end
