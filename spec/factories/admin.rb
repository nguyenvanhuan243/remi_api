FactoryGirl.define do
  factory :admin do
    email 'admin@viecdayroi.com'
    password 'Password1'
    token_admin SecureRandom.urlsafe_base64.to_s
  end
end
