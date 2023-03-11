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
