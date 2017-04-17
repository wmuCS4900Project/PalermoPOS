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
    
    trait :o1 do
      role_id '3'
      action 'view'
      object 'orders'
    end
    trait :o2 do
      role_id '3'
      action 'create'
      object 'orders'
    end
    trait :o3 do
      role_id '3'
      action 'edit'
      object 'orders'
    end
    trait :o4 do
      role_id '3'
      action 'cancel'
      object 'orders'
    end
    trait :o5 do
      role_id '3'
      action 'destroy'
      object 'orderlines'
    end
    trait :o6 do
      role_id '3'
      action 'view'
      object 'products'
    end
    trait :o7 do
      role_id '3'
      action 'view'
      object 'options'
    end
    trait :o8 do
      role_id '3'
      action 'view'
      object 'coupons'
    end
    trait :o9 do
      role_id '3'
      action 'view'
      object 'orders'
    end
    trait :o10 do
      role_id '3'
      action 'view'
      object 'customers'
    end
    trait :o11 do
      role_id '3'
      action 'edit'
      object 'customers'
    end
    trait :o12 do
      role_id '3'
      action 'create'
      object 'customers'
    end
    
  end
end