class Vet < ApplicationRecord
  belongs_to :user, optional: true
  
  has_many :appointments

  validates :first_name, :last_name, :specialization, presence: true
  validates :email,
            presence: true,
            uniqueness: true,
            format: { with: URI::MailTo::EMAIL_REGEXP }

  before_validation :normalize_email

  scope :by_specialization, ->(specialization) { where(specialization: specialization) }

  def full_name
    "#{first_name} #{last_name}"
  end

  private

  def normalize_email
    self.email = email.to_s.strip.downcase
  end
end