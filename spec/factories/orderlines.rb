FactoryGirl.define do
  factory :orderline do
    
    trait :one do
      order_id "1"
      Options1 '["1"]'
      splitstyle "whole"
      product_id "2"
    end
  end
end