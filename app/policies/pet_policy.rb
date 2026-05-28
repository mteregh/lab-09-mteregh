class PetPolicy < ApplicationPolicy
  class Scope < ApplicationPolicy::Scope
    def resolve
      if user.admin? || user.vet?
        scope.all
      elsif user.owner?
        scope.joins(:owner).where(owners: { user_id: user.id })
      else
        scope.none
      end
    end
  end

  def show?
    user.admin? || user.vet? || owns_pet?
  end

  def create?
    user.admin? || user.owner?
  end

  def update?
    user.admin? || owns_pet?
  end

  def destroy?
    user.admin? || owns_pet?
  end

  def permitted_attributes
    if user.admin?
      [:name, :species, :breed, :date_of_birth, :weight, :owner_id, :photo]
    else
      [:name, :species, :breed, :date_of_birth, :weight, :photo]
    end
  end

  private

  def owns_pet?
    user.owner? && record.owner&.user_id == user.id
  end
end