FactoryGirl.define do
  factory :option do
    
    trait :sub1 do
      category_id "2"
      id "1"
      Name "Ham"
      Cost ".5"
      Abbreviation "H"
    end
    trait :sub2 do
      category_id "2"
      id "2"
      Name "Sausage"
      Cost ".5"
      Abbreviation "S"
    end
    trait :sub3 do
      category_id "2"
      id "3"
      Name "Pepperoni"
      Cost ".5"
      Abbreviation "P"
    end
    trait :sub4 do
      category_id "2"
      id "4"
      Name "Onion"
      Cost ".5"
      Abbreviation "O"
    end
    trait :sub5 do
      category_id "2"
      id "5"
      Name "Mushroom"
      Cost ".5"
      Abbreviation "M"
    end
    trait :sub6 do
      category_id "2"
      id "6"
      Name "Extra Cheese"
      Cost "1"
      Abbreviation "Exchs"
    end
      
    
    trait :pizza1 do
      category_id "1"
      id "7"
      Name "Ham"
      Cost "1"
      Abbreviation 'Ham'
    end
    trait :pizza2 do
      category_id "1"
      id "8"
      Name "Sausage"
      Cost "1"
      Abbreviation 'Sau'
    end
    trait :pizza3 do
      category_id "1"
      id "9"
      Name "Pepperoni"
      Cost "1"
      Abbreviation 'Pep'
    end
    trait :pizza4 do
      category_id "1"
      id "10"
      Name "Onion"
      Cost "1"
      Abbreviation 'Oni'
    end
    trait :pizza5 do
      category_id "1"
      id "11"
      Name "Mushroom"
      Cost "1"
      Abbreviation 'Mus'
    end
    trait :pizza6 do
      category_id "1"
      id "12"
      Name "Extra Cheese"
      Cost "2"
      Abbreviation 'xCHS'
    end
  end
end