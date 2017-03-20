FactoryGirl.define do
  factory :category do
    
    trait :pizza do
      id "1"
      Name "12 Inch Pizzas"
      Splits "1"
      created_at { DateTime.now }
    end
    
    trait :subs do
      id "7"
      Name "Subs"
      Splits "0"
      created_at { DateTime.now }
    end
    
  end
end