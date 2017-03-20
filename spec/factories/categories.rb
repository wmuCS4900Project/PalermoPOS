FactoryGirl.define do
  factory :category do
    
    trait :pizza do
      id "1"
      Name "12 Inch Pizzas"
      Abbreviation '12 Inch'
      Splits "1"
      created_at { DateTime.now }
    end
    
    trait :subs do
      id "2"
      Name "Subs"
      Abbreviation 'Subs'
      Splits "0"
      created_at { DateTime.now }
    end
    
  end
end