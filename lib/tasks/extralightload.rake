#lib/tasks/extralightload.rake
namespace :extralightload do
  desc "Sets all products to have the right free options"
  task :loadall, [:filename] => :environment do  
    Category.all.each do |cat|
      @ops = Option.where('category_id = ?', cat.id).all
      @ops.each do |a|
        if !a.include?("extra") && !a.include?("light")
          @ops2 = Option.where('category_id = ?', a.id).all
          @ops2.each do |b|
            if b.include?("extra") || b.include?("light")
              if b.include?(a.Name)
                b.ChildOf = a.id
                b.save!
              end
            end
          end
        end
      end
    end
  end
end