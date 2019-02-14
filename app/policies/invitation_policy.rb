class InvitationPolicy < ApplicationPolicy

  def new?
    standard_check
  end

  def create?
    #Check that the email is not in use by a user already
    standard_check && User.where(email: record.email).empty?
  end

  def permitted_attributes
    %i[invited_by_id sent_at accepted_at token email]
  end

private

  def admin_or_owner?
    user.admin? || user.owner?
  end

  def standard_check
    record.invited_by_id == user.id && admin_or_owner?
  end
end
