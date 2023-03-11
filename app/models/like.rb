class Like < ApplicationRecord
  # == Extensions ===========================================================
  enum status: { dislike: 0, like: 1 }

  # == Validations ==========================================================
  validates_uniqueness_of :user_id, scope: :movie_id
  validates :status, uniqueness: true
  validates :status, presence: true

  # == Scopes ===============================================================
  scope :likes, -> { where(status: Like.statuses[:like]) }
  scope :dislikes, -> { where(status: Like.statuses[:dislike]) }

  # == Relationships ========================================================
  belongs_to :movie
  belongs_to :user
end
