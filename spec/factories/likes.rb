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
FactoryGirl.define do
  factory :like do
    movie nil
    user nil
    like_type 1
  end
end
