
class ApplicationQuery
  def self.query_for *method_names, &block
    method_names.each {|name| define_singleton_method name, &block}
  end

  def self.find record_id
    model.find record_id
  end

  def self.all
    model.all
  end

  def self.find_by attribute_hash
    model.find_by attribute_hash
  end

  def self.model
    @model ||= const_get self.name.gsub(/Query/, '').singularize
  end
end
