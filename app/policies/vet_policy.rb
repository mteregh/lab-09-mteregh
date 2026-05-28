class VetPolicy < ApplicationPolicy
  class Scope < ApplicationPolicy::Scope
    def resolve
      if user.admin? || user.vet? || user.owner?
        scope.all
      else
        scope.none
      end
    end
  end

  def show?
    user.admin? || user.vet? || user.owner?
  end

  def create?
    user.admin?
  end

  def update?
    user.admin? || own_vet_record?
  end

  def destroy?
    user.admin?
  end

  def permitted_attributes
    if user.admin?
      [:first_name, :last_name, :phone, :email, :specialization, :user_id]
    else
      [:first_name, :last_name, :phone, :email, :specialization]
    end
  end

  private

  def own_vet_record?
    user.vet? && record.user_id == user.id
  end
  
end