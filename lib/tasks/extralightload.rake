#lib/tasks/extralightload.rake
namespace :extralightload do
  desc "Sets all products to have the right free options"
  task :loadall, [:filename] => :environment do  
    Option.all.each do |a|
      if !a.Name.include?("Extra") && !a.Name.include?("Light")
        #puts "looking at " + a.Name
        @ops2 = Option.where('category_id = ?', a.category_id).all
        #puts "found " + @ops2.inspect
        @ops2.each do |b|
          #puts "considering " + b.Name
          if b.Name.include?("Extra") || b.Name.include?("Light")
            #puts "further considering " + b.Name
            if b.Name.include?(a.Name)
              #puts b.Name + " is now a child of " + a.Name
              b.ChildOf = a.id
              b.save!
            end
          end
        end
        
      end
    end
  end
end