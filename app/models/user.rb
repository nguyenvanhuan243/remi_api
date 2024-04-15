# == Schema Information
#
# Table name: users
#
#  id               :integer          not null, primary key
#  email            :string
#  password         :string
#  confirm_password :string
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#
# User
class User < ApplicationRecord
  # == Extensions ===========================================================
  enum user_type: {
    normal: 0,
    admin: 1
  }
  # == Relationships ========================================================
  has_many :movies, dependent: :destroy
  has_many :assets, dependent: :destroy
  has_many :payments, dependent: :destroy
  has_many :reactions, dependent: :destroy
  has_many :reacted_movies, through: :reactions, source: 'movie'

  # == Validations ==========================================================
  validates :email, uniqueness: true
  validates :password, presence: true
  validates :email, presence: true, format: { with: URI::MailTo::EMAIL_REGEXP }
end
