FactoryGirl.define do
  factory :palconfig do
    trait :delivery do
      id '1'
      name 'delivery'
      val1 '2.0'
    end
    
    trait :longdelivery do
      id '2'
      name 'deliverylong'
      val1 '3.0'
    end
    
    trait :optiondisplayshort do
      id '3'
      name 'optiondisplay'
      val1 'short'
    end
    
    trait :optiondisplaylong do
      id '4'
      name 'optiondisplay'
      val1 'long'
    end
  end
end
