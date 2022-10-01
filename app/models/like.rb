class Like < ApplicationRecord
  belongs_to :movie
  belongs_to :user
  enum status: { dislike: 0, like: 1 }
  validates_uniqueness_of :user_id, scope: :movie_id
  scope :likes, -> { where(status: 1) }
  scope :dislikes, -> { where(status: 0) }
end
