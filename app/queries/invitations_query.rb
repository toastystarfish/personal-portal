
class InvitationsQuery < ApplicationQuery

  # Add queries by passing a block to the query_for method

  query_for :delete_with_email do |email|
    Invitation.where(email: email).delete_all
  end

  query_for :first_with_token do |token|
    Invitation.where(token: token).first
  end
end
