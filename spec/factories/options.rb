FactoryGirl.define do
  factory :option do
    trait :subone do
      category_id "7"
      id "1"
      Name "Ham"
      Cost "1"
    end
    trait :subtwo do
      category_id "7"
      id "2"
      Name "Sausage"
      Cost "1.5"
    end
    
    trait :pizzaone do
      category_id "1"
      id "3"
      Name "Pepperoni"
      Cost "2"
    end
    trait :pizzatwo do
      category_id "1"
      id "4"
      Name "Onion"
      Cost ".5"
    end
  end
end