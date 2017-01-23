FactoryGirl.define do
  factory :product do
    
    trait :one do
      id "1"
      Name "Plain Sub"
      Cost "5"
      category_id "7"
      created_at { DateTime.now }
    end
    
    trait :two do
      id "2"
      Name "12 Inch Pizza"
      Cost "10"
      category_id "1"
      created_at { DateTime.now }
    end
    
  end
end