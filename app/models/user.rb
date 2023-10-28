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
  # == Relationships ========================================================
  has_many :movies, dependent: :destroy

  # == Validations ==========================================================
  validates :email, uniqueness: true
  validates :password, presence: true
  validates :email, presence: true, format: { with: URI::MailTo::EMAIL_REGEXP }

end
