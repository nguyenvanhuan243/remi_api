# == Schema Information
#
# Table name: movies
#
#  id          :integer          not null, primary key
#  user_id     :integer
#  title       :string
#  description :text
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  embed_url   :string
#
class Movie < ApplicationRecord
  belongs_to :user
  validates :embed_url, presence: true
  has_many :reactions, dependent: :destroy
  has_many :reacted_users, through: :reactions, source: 'user'

  def shared_by
    user.email
  end

  after_create_commit :clear_cache

  private

  # == Instant methods ============================================================
  def clear_cache
    Rails.cache.delete_matched 'movie*'
  end
end
