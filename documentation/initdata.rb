@u = User.create :Name => "DefaultUser", :Password => "admin", :Driver => false, :IsManager => true
@u1 = User.create :Name => "Nate", :Password => "nate1", :Driver => true, :IsManager => false
@u2 = User.create :Name => "Joe", :Password => "joe1", :Driver => true, :IsManager => true
@u3 = User.create :Name => "BJ", :Password => "bj1", :Driver => false, :IsManager => false
@c = Customer.create :Phone => 6161112222, :LastName => "Smith", :FirstName =>"Jim", :AddressNumber => "213", :StreetName => "Rue Rd", :City => "Kalamazoo", :State => "MI", :Zip => "49001", :LongDelivery => true
@c1 = Customer.create :Phone => 2695123654, :LastName => "Johnson", :FirstName =>"Rick", :AddressNumber => "456", :StreetName => "Street St", :City => "Kalamazoo", :State => "MI", :Zip => "49001", :LongDelivery => false
@c2 = Customer.create :Phone => 7894561230, :LastName => "Adams", :FirstName =>"Tim", :AddressNumber => "123", :StreetName => "Bowl Blvd", :City => "Portage", :State => "MI", :Zip => "49012", :LongDelivery => false
@p = Product.create :Name => "12 inch pizza", :Cost => 8.99, :Category => :pizza, :Special => false, :DoesHalves => true, :DoesQuarters => true, :Generic => true
@p1 = Product.create :Name => "16 inch pizza", :Cost => 11.99, :Category => :pizza, :Special => false, :DoesHalves => true, :DoesQuarters => true, :Generic => true
@p2 = Product.create :Name => "12 inch deluxe pizza", :Cost => 13.99, :Category => :pizza, :Special => true, :DoesHalves => true, :DoesQuarters => true
@o1 = Option.create :Name => "Ham (12 inch pizza)", :Cost => 1.5, :product_id => 4
@o2 = Option.create :Name => "Sausage (12 inch pizza)", :Cost => 1.5, :product_id => 4
@o3 = Option.create :Name => "Onion (12 inch pizza)", :Cost => 1.0, :product_id => 4