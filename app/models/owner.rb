class Owner < ApplicationRecord
  belongs_to :user, optional: true

  has_many :pets

  validates :first_name, :last_name, :phone, presence: true
  validates :email,
            presence: true,
            uniqueness: true,
            format: { with: URI::MailTo::EMAIL_REGEXP }

  before_validation :normalize_email

  def full_name
    "#{first_name} #{last_name}"
  end

  #private

  def normalize_email
    self.email = email.to_s.strip.downcase
  end
end