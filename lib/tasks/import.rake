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
    task :customers, [:filename] => :environment do  
      if !Customer.exists?(lastname: 'Customer', firstname:  'Walk In')
        Customer.create :Phone => 9999999999, :LastName => "Customer", :FirstName => "Walk In", :LongDelivery => false
      end
  end 

  desc "Create admin if not exists, add admin role with all capabilities"
    task :admin, [:filename] => :environment do
      # Create admin if needed
      user = User.where(:username => 'admin')

      if user.empty?
        # Create active record
        user = User.new(:username => 'admin', :Name => "Admin", :password => "Palermo123")
        
        # Save to database
        user.save!
      end

      # Add admin role
      user.add_role(:admin)

      # Give all capabilities to admin
      role_id = Role.where(:name => :admin).pluck(:id)

      Cap.new(:role_id => role_id, :action => "all", :object => "all")
    end 
end