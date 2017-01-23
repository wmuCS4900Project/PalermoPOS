FactoryGirl.define do
  factory :order do
    
    trait :one do
      customer_id "1"
      user_id "1"
      created_at { DateTime.now }
      PaidFor "0"
    end
  end
end