#lib/tasks/wipeandreload.rake
namespace :wipeandreload do
  desc "Wipes out the database of entries and reenter them all with auto_increments starting at 1"
  #CAREFUL! wipes orders, orderlines, categories, products and options currently
    task :doit, [:filename] => :environment do  
      ActiveRecord::Base.connection.execute("delete from orderlines;")
      ActiveRecord::Base.connection.execute("delete from orders;")
      ActiveRecord::Base.connection.execute("delete from options;")
      ActiveRecord::Base.connection.execute("delete from products;")
      ActiveRecord::Base.connection.execute("delete from categories")
      
      ActiveRecord::Base.connection.execute("alter table orders AUTO_INCREMENT = 1")
      ActiveRecord::Base.connection.execute("alter table orderlines AUTO_INCREMENT = 1")
      ActiveRecord::Base.connection.execute("alter table categories AUTO_INCREMENT = 1")
      ActiveRecord::Base.connection.execute("alter table products AUTO_INCREMENT = 1")
      ActiveRecord::Base.connection.execute("alter table options AUTO_INCREMENT = 1")
      
      Rake::Task["import:categories"].invoke
      Rake::Task["import:products"].invoke
      Rake::Task["import:options"].invoke
      
      Rake::Task["freeoptionsload:loadall"].invoke
      Rake::Task["extralightload:loadall"].invoke
  end
  
end