FactoryGirl.define do
  factory :credit_amount do
    account_type "MyString"
    account_id 1
    country_code "MyString"
    amount 1.5
    credit_amount_type 1
    account nil
  end
end
