#lib/tasks/import.rake
require 'csv'
namespace :import do
  desc "Imports a CSV file into an ActiveRecord table"
    task :categories, [:filename] => :environment do  
      CSV.foreach('dbimport/categories.csv', :headers => true) do |row|
        Category.create!(row.to_hash)
      end
    end
  
  desc "Imports a CSV file into an ActiveRecord table"
    task :products, [:filename] => :environment do  
      CSV.foreach('dbimport/products.csv', :headers => true) do |row|
        Product.create!(row.to_hash)
      end
    end
  
  desc "Imports a CSV file into an ActiveRecord table"
    task :options, [:filename] => :environment do  
      CSV.foreach('dbimport/options.csv', :headers => true) do |row|
        Option.create!(row.to_hash)
      end
    end

  desc "Imports default customers, for example Walk In Customer "
    task :customers => :environment do  
      if !Customer.exists?(lastname: 'Customer', firstname:  'Walk In')
        Customer.create :Phone => 9999999999, :LastName => "Customer", :FirstName => "Walk In", :LongDelivery => false
        puts "created walkin"
      end
    end 
    
  desc "creates default coupons" #run this AFTER products exist
    task :coupons => :environment do
      
      this = Product.find_by(:Name => "18 Inch Pizza")
      if !this.nil?
        Coupon.create :Name => '18" 1 Item Special', :Type => 0, :DollarsOff => '2.0', :ProductData => [this.id.to_s,'','','','','','','','',''], :ProductType => ['0','','','','','','','','',''], :ProductMinOptions => ['1','','','','','','','','','']
      end
      
      this = Product.find_by(:Name => "14 Inch Pizza")
      if !this.nil?
        Coupon.create :Name => '14" 3 Item Special', :Type => 0, :DollarsOff => '2.0', :ProductData => [this.id.to_s,'','','','','','','','',''], :ProductType => ['0','','','','','','','','',''], :ProductMinOptions => ['3','','','','','','','','','']
      end
      
      this = Product.find_by(:Name => "14 Inch Deluxe")
      if !this.nil?
        Coupon.create :Name => '14" Deluxe Coupon', :Type => 0, :DollarsOff => '2.0', :ProductData => [this.id.to_s,'','','','','','','','',''], :ProductType => ['0','','','','','','','','',''], :ProductMinOptions => ['','','','','','','','','','']
      end
      
      this = Product.find_by(:Name => "14 Inch Deluxe")
      this2 = Product.find_by(:Name => "Cheesy Bread")
      if !this.nil? && !this2.nil?
        Coupon.create :Name => '14" Deluxe Coupon + Cheesy Bread', :Type => 0, :DollarsOff => '2.0', :ProductData => [this.id.to_s,this2.id.to_s,'','','','','','','',''], :ProductType => ['0','0','','','','','','','',''], :ProductMinOptions => ['','','','','','','','','','']
      end
      
      this = Product.find_by(:Name => "16 Inch Pizza")
      this2 = Product.find_by(:Name => "Cheesy Bread")
      if !this.nil? && !this2.nil?
        Coupon.create :Name => 'Palermo Trio Coupon', :Type => 0, :DollarsOff => '2.0', :ProductData => [this.id.to_s,this2.id.to_s,'2 Liter','','','','','','',''], :ProductType => ['0','0','2','','','','','','',''], :ProductMinOptions => ['2','','','','','','','','','']
      end
      
      this = Product.find_by(:Name => "12 Inch Pizza")
      if !this.nil?
        Coupon.create :Name => 'Two 3 Toppers Coupon', :Type => 0, :DollarsOff => '2.0', :ProductData => [this.id.to_s,this.id.to_s,'','','','','','','',''], :ProductType => ['0','0','','','','','','','',''], :ProductMinOptions => ['3','','','','','','','','','']
      end
      
      this = Product.find_by(:Name => "12 Inch Pizza")
      this2 = Product.find_by(:Name => "Cheesy Bread")
      if !this.nil? && !this2.nil?
        Coupon.create :Name => 'Two 3 Toppers Coupon + Cheesy Bread', :Type => 0, :DollarsOff => '2.0', :ProductData => [this.id.to_s,this.id.to_s,this2.id.to_s,'','','','','','',''], :ProductType => ['0','0','0','','','','','','',''], :ProductMinOptions => ['3','3','','','','','','','','']
      end
      
      this = Product.find_by(:Name => "18 Inch Pizza")
      if !this.nil?
        Coupon.create :Name => '18" 3 Item w/ 2 Liter Coupon', :Type => 0, :DollarsOff => '2.0', :ProductData => [this.id.to_s,'','','','','','','','',''], :ProductType => ['0','','','','','','','','',''], :ProductMinOptions => ['3','','','','','','','','','']
      end
      
      this = Product.find_by(:Name => "18 Inch Pizza")
      this2 = Product.find_by(:Name => "Cheesy Bread")
      if !this.nil? && !this2.nil?
        Coupon.create :Name => '18" 3 Item w/ 2 Liter Coupon + Cheesy Bread', :Type => 0, :DollarsOff => '2.0', :ProductData => [this.id.to_s,'2 Liter',this2.id.to_s,'','','','','','',''], :ProductType => ['0','2','0','','','','','','',''], :ProductMinOptions => ['3','','','','','','','','','']
      end
      
      this = Product.find_by(:Name => "16 Inch Deluxe")
      this2 = Product.find_by(:Name => "12 Inch Pizza")
      if !this.nil? && !this2.nil?
        Coupon.create :Name => 'Family Special Coupon', :Type => 0, :DollarsOff => '2.0', :ProductData => [this.id.to_s,this2.id.to_s,'2 Liter','','','','','','',''], :ProductType => ['0','0','2','','','','','','',''], :ProductMinOptions => ['0','1','','','','','','','','']
      end
      
      this = Product.find_by(:Name => "12 Inch Pizza")
      if !this.nil?
        Coupon.create :Name => '12" Crispy Thin Coupon', :Type => 0, :DollarsOff => '2.0', :ProductData => [this.id.to_s,'','','','','','','','',''], :ProductType => ['0','','','','','','','','',''], :ProductMinOptions => ['1','','','','','','','','','']
      end
      
      this = Product.find_by(:Name => "12 Inch Pizza")
      this2 = Product.find_by(:Name => "Cheesy Bread")
      if !this.nil? && !this2.nil?
        Coupon.create :Name => '12" Crispy Thin Coupon + Cheesy Bread', :Type => 0, :DollarsOff => '2.0', :ProductData => [this.id.to_s,this2.id.to_s,'','','','','','','',''], :ProductType => ['0','0','','','','','','','',''], :ProductMinOptions => ['1','','','','','','','','','']
      end
      
      
      
    end
  
  desc "Creates a couple roles"
    task :roles => :environment do  
      if !Role.exists?(name: 'admin')
        Role.create :name => 'admin', :id => '1'
      end
      if !Role.exists?(name: 'driver')
        Role.create :name => 'driver', :id => '2'
      end
      if !Role.exists?(name: 'user')
        Role.create :name => 'user', :id => '3'
      end
    end
    
  desc "Creates caps for those roles"
    task :caps => :environment do  
      #admin caps
      Cap.create :role_id => '1', :action => 'all', :object => 'all'
      
      #drivers dont really need any capabilities, most/all of them should also be users
      
      #user caps
      #create, edit, and view orders
      Cap.create :role_id => '3', :action => 'view', :object => 'orders'
      Cap.create :role_id => '3', :action => 'create', :object => 'orders'
      Cap.create :role_id => '3', :action => 'edit', :object => 'orders'
      Cap.create :role_id => '3', :action => 'cancel', :object => 'orders'
      Cap.create :role_id => '3', :action => 'destroy', :object => 'orderlines'
      #only view products, options, coupons
      Cap.create :role_id => '3', :action => 'view', :object => 'products'
      Cap.create :role_id => '3', :action => 'view', :object => 'options'
      Cap.create :role_id => '3', :action => 'view', :object => 'coupons'
      #view, edit, and create customers
      Cap.create :role_id => '3', :action => 'view', :object => 'customers'
      Cap.create :role_id => '3', :action => 'edit', :object => 'customers'
      Cap.create :role_id => '3', :action => 'create', :object => 'customers'
      
    end

  desc "Create admin if not exists, add admin role with all capabilities"
    task :admin, [:filename] => :environment do
      # Create admin if needed
      user = User.find_by(:username => 'admin')

      if user == nil
        # Create active record
        user = User.new(:username => 'admin', :Name => "Admin", :password => "Palermo123")
        # Save to database
        user.save!
        # Add admin role
        user.add_role(:admin)
      end
      # Give all capabilities to admin
      role_id = Role.find_by(:name => :admin).id
      
      cap = Cap.find_by(:action => 'all')
        if cap == nil
        cap = Cap.create(:role_id => role_id, :action => "all", :object => "all")
        cap.save!
      end
    end 
end