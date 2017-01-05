User.create :Name => "DefaultUser", :Password => "admin", :Driver => false, :IsManager => true
User.create :Name => "Nate", :Password => "nate1", :Driver => true, :IsManager => false
User.create :Name => "Joe", :Password => "joe1", :Driver => true, :IsManager => true
User.create :Name => "BJ", :Password => "bj1", :Driver => false, :IsManager => false

Driver.create :user_id => 2
Driver.create :user_id => 3

Category.create :Name => "12 Inch Pizzas", :Splits => true
Category.create :Name => "16 Inch Pizzas", :Splits => true
Category.create :Name => "18 Inch Pizzas", :Splits => true
Category.create :Name => "24 Inch Pizzas", :Splits => true
Category.create :Name => "Sides", :Splits => false
Category.create :Name => "Drinks", :Splits => false
Category.create :Name => "Subs", :Splits => false
Category.create :Name => "Salads", :Splits => false
Category.create :Name => "Dinners", :Splits => false
Category.create :Name => "Desserts", :Splits => false

Customer.create :Phone => 9999999999, :LastName => "Customer", :FirstName => "Walk In", :LongDelivery => false
Customer.create :Phone => 6161112222, :LastName => "Smith", :FirstName =>"Jim", :AddressNumber => "213", :StreetName => "Rue Rd", :City => "Kalamazoo", :State => "MI", :Zip => "49001", :LongDelivery => true
Customer.create :Phone => 2695123654, :LastName => "Johnson", :FirstName =>"Rick", :AddressNumber => "456", :StreetName => "Street St", :City => "Kalamazoo", :State => "MI", :Zip => "49001", :LongDelivery => false
Customer.create :Phone => 7894561230, :LastName => "Adams", :FirstName =>"Tim", :AddressNumber => "123", :StreetName => "Bowl Blvd", :City => "Portage", :State => "MI", :Zip => "49012", :LongDelivery => false

Product.create :Name => "empty", :Cost => 0.00, :category_id => 1
Product.create :Name => "12 inch pizza", :Cost => 8.99, :category_id => 1
Product.create :Name => "16 inch pizza", :Cost => 11.99, :category_id => 2
Product.create :Name => "Plain Sub", :Cost => 4.99, :category_id => 7


Option.create :Name => "Ham", :Cost => 1, :category_id => 1
Option.create :Name => "Sausage", :Cost => 1, :category_id => 1
Option.create :Name => "Onion", :Cost => 1, :category_id => 1

Option.create :Name => "Ham", :Cost => 2, :category_id => 2
Option.create :Name => "Sausage", :Cost => 2, :category_id => 2
Option.create :Name => "Onion", :Cost => 2, :category_id => 2

Option.create :Name => "Ham", :Cost => 0.5, :category_id => 7
Option.create :Name => "Lettuce", :Cost => 0.5, :category_id => 7
Option.create :Name => "Sausage", :Cost => 0.5, :category_id => 7