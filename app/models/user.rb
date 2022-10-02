# User
class User < ApplicationRecord
  extend Enumerize
  validates :email, uniqueness: true
  validates :email, presence: true, format: { with: URI::MailTo::EMAIL_REGEXP }
  validates :password, presence: true
  has_many :movies
end
