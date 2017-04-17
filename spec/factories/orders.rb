FactoryGirl.define do
  factory :order do
    
    trait :one do
      id '1'
      customer_id '1'
      user_id '1'
      DailyID '1'
    end
    
    trait :two do
      id '2'
      customer_id '1'
      user_id '1'
      DailyID '2'
      TotalCost '5.00'
    end
    
    trait :new do
      created_at { DateTime.now }
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