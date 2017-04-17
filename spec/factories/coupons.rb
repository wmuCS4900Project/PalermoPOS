FactoryGirl.define do
  factory :coupon do
    
    trait :coupon1 do
      id '1'
      Name "2 Item 12 Inch"
      Type 0
      DollarsOff "1.25"
      PercentOff 0
      ProductData = ['2','','','','','','','','','']
      ProductType = ['0','','','','','','','','','']
      ProductMinOptions = ['','','','','','','','','','']
    end
    
  end
end
