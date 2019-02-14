<% if namespaced? -%>
require_dependency "<%= namespaced_path %>/resources_controller"
<% end -%>
<% module_namespacing do -%>
class <%= controller_class_name %>Controller < ResourcesController
  resource_model <%= class_name %>

  # Configure permitted params in the generated policy
end
<% end -%>
