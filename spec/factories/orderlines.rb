FactoryGirl.define do
  factory :orderline do
    
    trait :one do
      order_id "1"
      Options1 '["1"]'
      splitstyle "0"
    end
  end
end