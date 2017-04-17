FactoryGirl.define do
  factory :role do
    
    created_at { DateTime.now }
    updated_at { DateTime.now }
    
    trait :admin do
      id "1"
      name 'admin'
    end
    
    trait :driver do
      id "2"
      name 'driver'
    end
    
    trait :userdef do
      id '3'
      name 'userdef'
    end
    
  end
end