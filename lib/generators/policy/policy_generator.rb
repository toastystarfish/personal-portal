class PolicyGenerator < ::Rails::Generators::NamedBase
  include ::Rails::Generators::ResourceHelpers

  source_root File.expand_path("../templates", __FILE__)

  ATTR_NAME_DESC = "List of attributes for controller whitelisting, default is blank"
  argument :attribute_names, type: :array, default: [], desc: ATTR_NAME_DESC

  def create_policy
    template 'policy.rb', File.join('app/policies', class_path, "#{file_name}_policy.rb")
  end

  def create_test
    template 'policy_test.rb', File.join('test/policies', class_path, "#{file_name}_policy_test.rb")
  end
end
