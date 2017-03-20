FactoryGirl.define do
  factory :cap do
    
    created_at { DateTime.now }
    updated_at { DateTime.now }
    
    trait :all do
      id "1"
      role_id "1"
      action "all"
      object "all"
    end
    
  end
end