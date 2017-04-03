
class UserPolicy < ApplicationPolicy
  def owners_or_admins?
    user.owner? || user.admin? || user.developer?
  end

  def owners_admins_or_self?
    record == user || owners_or_admins?
  end
  alias :show?    :owners_admins_or_self?
  alias :edit?    :owners_admins_or_self?
  alias :update?  :owners_admins_or_self?
  alias :destroy? :owners_admins_or_self?

  def registerable?
    (record.invitation.present? && record.invitation&.accepted_at.nil?) ||
    owners_or_admins?
  end
  alias :new? :registerable?
  alias :create? :registerable?
end
