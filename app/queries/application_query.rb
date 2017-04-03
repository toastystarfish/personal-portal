
class ApplicationQuery
  def self.query_for *method_names, &block
    method_names.each {|name| define_singleton_method name, &block}
  end
end
