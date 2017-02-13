FactoryGirl.define do
  factory :user do
    
    created_at { DateTime.now }
    updated_at { DateTime.now }
    
  end
end