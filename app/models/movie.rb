class Movie < ApplicationRecord
  belongs_to :user
  def shared_by
    User.find_by(id: user_id).email
  end
end
