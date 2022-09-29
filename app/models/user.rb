# User
class User < ApplicationRecord
  extend Enumerize
  validates :email, uniqueness: true
  has_many :movies
end
