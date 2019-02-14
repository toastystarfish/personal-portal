
class UserPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.all
    end
  end

  def index?
    true
  end

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

  def permitted_attributes_for_create
    %i[first_name last_name email password password_confirmation]
  end

  def permitted_params_for_update_no_pass
    %i[first_name last_name email]
  end

  def permitted_params_for_update_with_pass
    %i[first_name last_name email password password_confirmation]
  end
end
