FactoryGirl.define do
  factory :customer do

    trait :one do
      id "1"
      Phone "1112223333"
      LastName "Smith"
      FirstName "Jim"
      AddressNumber "201"
      StreetName "Moss St"
      City "Middleville"
      State "MI"
      Zip "49333"
      created_at { DateTime.now }
    end
    trait :two do
      id "2"
      Phone "4445556666"
      LastName "Brown"
      FirstName "Bob"
      AddressNumber "321"
      StreetName "The Rd"
      City "Kalamazoo"
      State "MI"
      Zip "49001"
      created_at { DateTime.now }
    end
    trait :three do
      id "3"
      Phone "1119998888"
      LastName "Archer"
      FirstName "Sterling"
      AddressNumber "123"
      StreetName "Grand St"
      City "Caledonia"
      State "MI"
      Zip "49222"
      created_at { DateTime.now }
    end
  end
end