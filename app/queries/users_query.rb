
class UsersQuery < ApplicationQuery

  # Action Queries are required by ResourceController by default
  query_for :index do |page, sort={}|
    relation = User
    relation = relation.order(sort) unless sort.blank?
    relation.paginate page: page, per_page: 10
  end

  query_for :find do |id|
    User.find(id)
  end

  # Add queries by passing a block to the query_for method

end
