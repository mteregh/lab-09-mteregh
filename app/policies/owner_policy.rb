class OwnerPolicy < ApplicationPolicy
  class Scope < ApplicationPolicy::Scope
    def resolve
      if user.admin? || user.vet?
        scope.all
      elsif user.owner?
        scope.where(user_id: user.id)
      else
        scope.none
      end
    end
  end

  def show?
    user.admin? || user.vet? || owns_record?
  end

  def create?
    user.admin?
  end

  def update?
    user.admin? || owns_record?
  end

  def destroy?
    user.admin?
  end

  def permitted_attributes
    if user.admin?
      [:first_name, :last_name, :email, :phone, :address, :user_id]
    else
      [:first_name, :last_name, :email, :phone, :address]
    end
  end

  private

  def owns_record?
    user.owner? && record.user_id == user.id
  end
end