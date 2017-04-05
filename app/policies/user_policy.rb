
class UserPolicy < ApplicationPolicy
  def owners_or_admins?
    user.owner? || user.admin?
  end

  def owners_admins_or_self?
    record == user || owners_or_admins?
  end
  alias :show?    :owners_admins_or_self?
  alias :edit?    :owners_admins_or_self?

  def update?
    owners_or_admins? || (record.id == user.id && !record.roles_mask_changed?)
  end

  def destroy?
    # owner or admin can delete but you cant delete yourself
    record != user && owners_or_admins?
  end

  def was_invited?
    record.invitation.present? && record.invitation.accepted_at.nil? &&
    !record.invitation.token_changed?
  end
  alias :new? :was_invited?
  alias :create? :was_invited?
end
