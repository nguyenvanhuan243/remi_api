# == Schema Information
#
# Table name: reactions
#
#  id            :integer          not null, primary key
#  user_id       :integer
#  movie_id      :integer
#  reaction_type :integer
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#
class Reaction < ApplicationRecord
  enum reaction_type: {
    like: 0
  }
  belongs_to :user
  belongs_to :movie

  validates :user_id, presence: true
  validates :movie_id, presence: true
  validates :user_id, uniqueness: {
    scope: :movie_id,
    message: 'has already liked this movie'
  }
end
