FactoryGirl.define do
  factory :order do
    
    trait :one do
      customer_id "1"
      user_id "1"
    end
    
    trait :two do
      customer_id "2"
      user_id "1"
    end
    
    trait :new do
      created_at { Datetime.now }
    end
    
    trait :old do
      created_at { DateTime.now - 4.days }
    end
    
    trait :pending do
      PaidFor false
      Cancelled false
      Refunded false
    end
    
    trait :completed do
      PaidFor true
      Cancelled false
      Refunded false
    end
    
    trait :refunded do
      PaidFor true
      Cancelled false
      Refunded true
    end
    
    trait :cancelled do
      PaidFor false
      Cancelled true
      Refunded false
    end
    
  end
end