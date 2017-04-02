FactoryGirl.define do
  factory :palconfig do
    trait :delivery do
      name 'delivery'
      val1 '2.0'
    end
    
    trait :longdelivery do
      name 'deliverylong'
      val1 '3.0'
    end
    
    trait :optiondisplayshort do
      name 'optiondisplay'
      val1 'short'
    end
    
    trait :optiondisplaylong do
      name 'optiondisplay'
      val1 'long'
    end
  end
end
