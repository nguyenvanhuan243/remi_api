# == Schema Information
#
# Table name: likes
#
#  id         :integer          not null, primary key
#  movie_id   :integer
#  user_id    :integer
#  like_type  :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  status     :integer
#
class Like < ApplicationRecord
  # == Extensions ===========================================================
  enum status: { dislike: 0, like: 1 }

  # == Validations ==========================================================
  validates :status, presence: true
  validates :status, uniqueness: true
  validates_uniqueness_of :user_id, scope: :movie_id

  # == Scopes ===============================================================
  scope :likes, -> { where(status: Like.statuses[:like]) }
  scope :dislikes, -> { where(status: Like.statuses[:dislike]) }

  # == Relationships ========================================================
  belongs_to :movie
  belongs_to :user
end
