FactoryGirl.define do
  factory :user do
    email Faker::Internet.email
    password Digest::MD5.hexdigest('123456')
  end
end
