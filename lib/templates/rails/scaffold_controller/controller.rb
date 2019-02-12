<% if namespaced? -%>
require_dependency "<%= namespaced_path %>/resources_controller"
<% end -%>
<% module_namespacing do -%>
class <%= controller_class_name %>Controller < ResourcesController
  resource_model <%= class_name %>

  private

  # # Only allow a trusted parameter "white list" through.
  # def <%= "#{singular_table_name}_params" %>
  #   <%- if attributes_names.empty? -%>
  #   params.fetch(:<%= singular_table_name %>, {})
  #   <%- else -%>
  #   params.require(:<%= singular_table_name %>).permit(<%= attributes_names.map { |name| ":#{name}" }.join(', ') %>)
  #   <%- end -%>
  # end
end
<% end -%>
