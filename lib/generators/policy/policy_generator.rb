class PolicyGenerator < ::Rails::Generators::NamedBase
  include ::Rails::Generators::ResourceHelpers

  source_root File.expand_path("../templates", __FILE__)

  class_option :attributes_names, type: :array, default: []

  def create_policy
    template 'policy.rb', File.join('app/policies', class_path, "#{file_name}_policy.rb")
  end

  hook_for :test_framework
end
