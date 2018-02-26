
class <%= controller_class_name %>Query < ApplicationQuery
  <% if resource? %>
  # Action Queries are required by ResourceController by default
  query_for :index do |page, sort={}|
    relation = <%= class_name %>
    relation = relation.order(sort) unless sort.blank?
    relation.paginate page: page, per_page: 10
  end
  <% end -%>

  # Add queries by passing a block to the query_for method

end
