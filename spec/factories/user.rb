FactoryGirl.define do
  factory :user do
    email Faker::Internet.email
    password 'Password1'
    user_name 'viecdayroi'
    full_name 'Viec day roi'
  end
end
