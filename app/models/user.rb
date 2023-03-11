# User
class User < ApplicationRecord
  # == Extensions ===========================================================
  extend Enumerize

  # == Relationships ========================================================
  has_many :movies

  # == Validations ==========================================================
  validates :email, uniqueness: true
  validates :email, presence: true, format: { with: URI::MailTo::EMAIL_REGEXP }
  validates :password, presence: true

  # == Custom validations =================
  validate :custom_validate_email

  # == Instant Methods ========================================================
  def custom_validate_email
    email_service = EmailVerifyService.new(email, 'power')
    errors.add(:email, email_service.message(true)) if !email_service.valid
  end
end
