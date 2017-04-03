
class QueryGenerator < ::Rails::Generators::NamedBase
  include ::Rails::Generators::ResourceHelpers

  source_root File.expand_path("../templates", __FILE__)

  class_option :as_resource, type: :boolean, default: false,
               desc: "Query should be generated with required action queries for ResourcesController"

  def create_query_object
    template 'query.rb', "app/queries/#{controller_file_name}_query.rb"
  end

  protected

  def resource?
    options[:as_resource]
  end
end
