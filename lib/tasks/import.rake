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
  
  
end