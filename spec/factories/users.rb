FactoryGirl.define do
  factory :user do
    
    created_at { DateTime.now }
    updated_at { DateTime.now }
    
    trait :admin do
        after(:create) {|user| user.add_role(:admin)}
    end
    
    trait :driver do
      after(:create) {|user| user.add_role(:driver)}
    end
    
    trait :userdef do
      after(:create) {|user| user.add_role(:userdef)}
    end
    
  end
end