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
  include Filterable
  belongs_to :user
  validates :embed_url, presence: true

  def shared_by
    User.find_by(id: user_id).email
  end

  after_create_commit :clear_cache

  private

  # == Instant methods ============================================================
  def clear_cache
    Rails.cache.delete 'movie*'
  end
end
