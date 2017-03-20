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


      @cap = Cap.create(:role_id => role_id, :action => "all", :object => "all")
      @cap.save!

    end 
end