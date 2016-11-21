@u = User.create :Name => "DefaultUser", :Password => "admin", :Driver => false, :IsManager => true
@u1 = User.create :Name => "Nate", :Password => "nate1", :Driver => true, :IsManager => false
@u2 = User.create :Name => "Joe", :Password => "joe1", :Driver => true, :IsManager => true
@u3 = User.create :Name => "BJ", :Password => "bj1", :Driver => false, :IsManager => false
@c = Customer.create :Phone => 6161112222, :LastName => "Smith", :FirstName =>"Jim", :AddressNumber => "213", :StreetName => "Rue Rd", :City => "Kalamazoo", :State => "MI", :Zip => "49001", :LongDelivery => true
@c1 = Customer.create :Phone => 2695123654, :LastName => "Johnson", :FirstName =>"Rick", :AddressNumber => "456", :StreetName => "Street St", :City => "Kalamazoo", :State => "MI", :Zip => "49001", :LongDelivery => false
@c2 = Customer.create :Phone => 7894561230, :LastName => "Adams", :FirstName =>"Tim", :AddressNumber => "123", :StreetName => "Bowl Blvd", :City => "Portage", :State => "MI", :Zip => "49012", :LongDelivery => false
@p = Product.create :Name => "12 inch pizza", :Category => 0