class User < ApplicationRecord
  has_one :owner, dependent: :nullify
  has_one :vet, dependent: :nullify

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable,
         :recoverable,
         :rememberable,
         :validatable

  enum :role, { owner: 0, vet: 1, admin: 2 }

  validates :first_name, :last_name, presence: true

  def full_name
    "#{first_name} #{last_name}"
  end
end