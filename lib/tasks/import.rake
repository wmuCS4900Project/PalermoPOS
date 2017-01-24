#lib/tasks/import.rake
require 'csv'
namespace :import do
  desc "Imports a CSV file into an ActiveRecord table"
    task :import1, [:filename] => :environment do  
      CSV.foreach('dbimport/products.csv', :headers => true) do |row|
        Product.create!(row.to_hash)
      end
  end
end