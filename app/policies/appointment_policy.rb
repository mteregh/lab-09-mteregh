class AppointmentPolicy < ApplicationPolicy
  class Scope < ApplicationPolicy::Scope
    def resolve
      if user.admin?
        scope.all
      elsif user.vet?
        scope.joins(:vet).where(vets: { user_id: user.id })
      elsif user.owner?
        scope.joins(pet: :owner).where(owners: { user_id: user.id })
      else
        scope.none
      end
    end
  end

  def show?
    user.admin? || assigned_vet? || owns_pet_appointment?
  end

  def create?
    user.admin? || user.vet? || user.owner?
  end

  def update?
    user.admin? || assigned_vet? || owns_pet_appointment?
  end

  def destroy?
    user.admin? || assigned_vet? || owns_pet_appointment?
  end

  def permitted_attributes
    if user.admin?
      [:pet_id, :vet_id, :date, :reason, :status]
    elsif user.vet?
      [:pet_id, :date, :reason, :status]
    elsif user.owner?
      [:vet_id, :date, :reason, :status]
    else
      []
    end
  end

  private

  def assigned_vet?
    user.vet? && record.vet&.user_id == user.id
  end

  def owns_pet_appointment?
    user.owner? && record.pet&.owner&.user_id == user.id
  end
  
end