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
FactoryGirl.define do
  factory :movie do
    title 'MyString'
    description 'MyText'
    embed_url 'Embed url'
  end
end
