#lib/tasks/freeoptionsload.rake
namespace :freeoptionsload do
  desc "Sets all products to have the right free options"
  task :loadall, [:filename] => :environment do  
    Category.all.each do |cat|
      
      if cat.Name.include? "Pizzas"
        Product.where("category_id = ?", cat).each do |a|
          @norm = ["pizza sauce","mozzer%"]
          @deluxe = ["pizza sauce","mozzer%","mushroom","pepperoni","sausage","ham","onion","green pepper"]
          @meat = ["pizza sauce","mozzer%","ham","pepperoni","sausage","bacon","ground beef"]
          @bbq = ["mozzer%","chicken","onion","bacon","barbeque%"]
          @greek = ["pizza sauce","mozzer%","black olives","tomatoes","banana%","feta%","onion"]
          @blt = ["mozzer%","bacon","lettuce","miracle%","tomatoes"]
          @veg = ["pizza sauce","mozzer%","mushroom","green pepper","onion","green olives","tomatoes"]
          @grilled = ["pizza sauce","mozzer%","chicken","onion","tomatoes","romano%"]
          @hawaiian = ["pizza sauce","mozzer%","ham","bacon","pineapple"]
          @super = ["pizza sauce","mozzer%","ham","pepperoni","banana peppers","bacon","black olives","green pepper","sausage","onion","ground beef","mushroom"]
          @ranch = ["mozzer%","chicken","bacon","tomatoes","ranch%"] 
          @alfredo = ["mozzer%","chicken","alfredo%"]
          @array = []
          
          if a.Name.include? "Pizza"
            @norm.each do |item|
              @array.push(Option.where("category_id = ? AND Name like ? AND Name NOT LIKE ?", cat, item, "extra").ids.to_s.delete! '[]')
            end
          elsif a.Name.include? "Super Deluxe"
            @super.each do |item|
              @array.push(Option.where("category_id = ? AND Name like ? AND Name NOT LIKE ?", cat, item, "extra").ids.to_s.delete! '[]')
            end 
          elsif a.Name.include? "Deluxe"
            @deluxe.each do |item|
              @array.push(Option.where("category_id = ? AND Name like ? AND Name NOT LIKE ?", cat, item, "extra").ids.to_s.delete! '[]')
            end
          elsif a.Name.include? "Meat"
            @meat.each do |item|
              @array.push(Option.where("category_id = ? AND Name like ? AND Name NOT LIKE ?", cat, item, "extra").ids.to_s.delete! '[]')
            end
          elsif a.Name.include? "BBQ"
            @bbq.each do |item|
              @array.push(Option.where("category_id = ? AND Name like ? AND Name NOT LIKE ?", cat, item, "extra").ids.to_s.delete! '[]')
            end 
          elsif a.Name.include? "Greek"
            @greek.each do |item|
              @array.push(Option.where("category_id = ? AND Name like ? AND Name NOT LIKE ?", cat, item, "extra").ids.to_s.delete! '[]')
            end 
          elsif a.Name.include? "BLT"
            @blt.each do |item|
              @array.push(Option.where("category_id = ? AND Name like ? AND Name NOT LIKE ?", cat, item, "extra").ids.to_s.delete! '[]')
            end 
          elsif a.Name.include? "Vegetarian"
            @veg.each do |item|
              @array.push(Option.where("category_id = ? AND Name like ? AND Name NOT LIKE ?", cat, item, "extra").ids.to_s.delete! '[]')
            end 
          elsif a.Name.include? "Grilled"
            @grilled.each do |item|
              @array.push(Option.where("category_id = ? AND Name like ? AND Name NOT LIKE ?", cat, item, "extra").ids.to_s.delete! '[]')
            end 
          elsif a.Name.include? "Hawaiian"
            @hawaiian.each do |item|
              @array.push(Option.where("category_id = ? AND Name like ? AND Name NOT LIKE ?", cat, item, "extra").ids.to_s.delete! '[]')
            end 
          elsif a.Name.include? "Ranch"
            @ranch.each do |item|
              @array.push(Option.where("category_id = ? AND Name like ? AND Name NOT LIKE ?", cat, item, "extra").ids.to_s.delete! '[]')
            end 
          elsif a.Name.include? "Alfredo"
            @alfredo.each do |item|
              @array.push(Option.where("category_id = ? AND Name like ? AND Name NOT LIKE ?", cat, item, "extra").ids.to_s.delete! '[]')
            end 
          else
            @array = []
          end
          
          if !@array.empty?
            a.freeoptions = @array
            a.save!
          end
        end
      elsif cat.Name.include? "Subs"
        Product.where("category_id = ?", cat).each do |a|
          @pep = ["pepperoni","pizza sauce","mozzer%"]
          @ham = ["ham","mozzer%"]
          @deluxe = ["ham","lettuce","onion","tomatoes","salad%","mozzer%"]
          @italian = ["salami","capi%","morta%","lettuce","tomatoes","italian%","mozzer%"]
          @meatball = ["meatballs","spagh%","mozzer%"]
          @sausage = ["sausage","spagh%","mozzer%"]
          @super = ["ham","capi%","salami","onion","pizza sauce","mushroom","pepperoni","green pepper","mozzer%"]
          @palermo = ["salami","capi%","ham","onion","pizza sauce","mozzer%"]
          @veg = ["mushroom","green olives","green pepper","onion","lettuce","tomatoes","salad%"]
          @allmeat = ["ham","capi%","pepperoni","pizza sauce","mozzer%","salami"]
          @pizza = ["ham","pepperoni","pizza sauce","mozzer%"]
          @roastbeefcheese = ["roast beef","mozzer%"]
          @roastbeefdeluxe = ["roast beef","lettuce","tomatoes","onion","salad%","mozzer%"]
          @steak = ["steak","onion","mushroom","lettuce","tomatoes","miracle%","mozzer%"]
          @turkeycheese = ["turkey","mozzer%"]
          @turkeydeluxe = ["turkey","lettuce","tomatoes","onion","salad%","mozzer%"]
          @blt = ["bacon","lettuce","tomatoes","salad%","mozzer%"]
          @club = ["ham","turkey","bacon","lettuce","tomatoes","salad%","mozzer%"]
          @bbq = ["chicken","bacon","barb%","onion","mozzer%"]
          
          @array = []
          
          if a.Name.include? "Pepperoni"
            @pep.each do |item|
              @array.push(Option.where("category_id = ? AND Name like ? AND Name NOT LIKE ?", cat, item, "extra").ids.to_s.delete! '[]')
            end 
          elsif a.Name.include? "Ham"
            @ham.each do |item|
              @array.push(Option.where("category_id = ? AND Name like ? AND Name NOT LIKE ?", cat, item, "extra").ids.to_s.delete! '[]')
            end
          elsif a.Name.include? "Super"
            @super.each do |item|
              @array.push(Option.where("category_id = ? AND Name like ? AND Name NOT LIKE ?", cat, item, "extra").ids.to_s.delete! '[]')
            end
          elsif a.Name.include? "Deluxe"
            @deluxe.each do |item|
              @array.push(Option.where("category_id = ? AND Name like ? AND Name NOT LIKE ?", cat, item, "extra").ids.to_s.delete! '[]')
            end
          elsif a.Name.include? "Italian"
            @italian.each do |item|
              @array.push(Option.where("category_id = ? AND Name like ? AND Name NOT LIKE ?", cat, item, "extra").ids.to_s.delete! '[]')
            end 
          elsif a.Name.include? "Meatball"
            @meatball.each do |item|
              @array.push(Option.where("category_id = ? AND Name like ? AND Name NOT LIKE ?", cat, item, "extra").ids.to_s.delete! '[]')
            end 
          elsif a.Name.include? "Sausage"
            @sausage.each do |item|
              @array.push(Option.where("category_id = ? AND Name like ? AND Name NOT LIKE ?", cat, item, "extra").ids.to_s.delete! '[]')
            end 
          elsif a.Name.include? "Palermo"
            @palermo.each do |item|
              @array.push(Option.where("category_id = ? AND Name like ? AND Name NOT LIKE ?", cat, item, "extra").ids.to_s.delete! '[]')
            end 
          elsif a.Name.include? "Vegetarian"
            @veg.each do |item|
              @array.push(Option.where("category_id = ? AND Name like ? AND Name NOT LIKE ?", cat, item, "extra").ids.to_s.delete! '[]')
            end 
          elsif a.Name.include? "All Meat"
            @allmeat.each do |item|
              @array.push(Option.where("category_id = ? AND Name like ? AND Name NOT LIKE ?", cat, item, "extra").ids.to_s.delete! '[]')
            end 
          elsif a.Name.include? "Pizza"
            @pizza.each do |item|
              @array.push(Option.where("category_id = ? AND Name like ? AND Name NOT LIKE ?", cat, item, "extra").ids.to_s.delete! '[]')
            end 
          elsif a.Name.include? "Roast Beef Deluxe"
            @roastbeefdeluxe.each do |item|
              @array.push(Option.where("category_id = ? AND Name like ? AND Name NOT LIKE ?", cat, item, "extra").ids.to_s.delete! '[]')
            end 
          elsif a.Name.include? "Roast Beef and Cheese"
            @roastbeefcheese.each do |item|
              @array.push(Option.where("category_id = ? AND Name like ? AND Name NOT LIKE ?", cat, item, "extra").ids.to_s.delete! '[]')
            end 
          elsif a.Name.include? "Steak"
            @steak.each do |item|
              @array.push(Option.where("category_id = ? AND Name like ? AND Name NOT LIKE ?", cat, item, "extra").ids.to_s.delete! '[]')
            end 
          elsif a.Name.include? "Turkey Deluxe"
            @turkeydeluxe.each do |item|
              @array.push(Option.where("category_id = ? AND Name like ? AND Name NOT LIKE ?", cat, item, "extra").ids.to_s.delete! '[]')
            end 
          elsif a.Name.include? "Turkey"
            @turkeycheese.each do |item|
              @array.push(Option.where("category_id = ? AND Name like ? AND Name NOT LIKE ?", cat, item, "extra").ids.to_s.delete! '[]')
            end 
          elsif a.Name.include? "BLT"
            @blt.each do |item|
              @array.push(Option.where("category_id = ? AND Name like ? AND Name NOT LIKE ?", cat, item, "extra").ids.to_s.delete! '[]')
            end 
          elsif a.Name.include? "Club"
            @club.each do |item|
              @array.push(Option.where("category_id = ? AND Name like ? AND Name NOT LIKE ?", cat, item, "extra").ids.to_s.delete! '[]')
            end 
          elsif a.Name.include? "Barbecue Chicken"
            @bbq.each do |item|
              @array.push(Option.where("category_id = ? AND Name like ? AND Name NOT LIKE ?", cat, item, "extra").ids.to_s.delete! '[]')
            end
          else
            @array = []
          end
          
          if !@array.empty?
            a.freeoptions = @array
            a.save!
          end
        end
        
      elsif cat.Name.include? "Salads"
        Product.where("category_id = ?", cat).each do |a|
          @chef = ["lettuce","tomatoes","mushroom","green pepper","mozzarella","pepperoni","ham"]
          @greek = ["lettuce","tomatoes","green pepper","onion","feta%","black%","peppercini"]
          @anti = ["lettuce","tomatoes","green pepper","black%","mozzarella","ham","salami","peppercini"]
          @chicken = ["lettuce","tomatoes","mushroom","green pepper","mozzarella","chicken"]
          @caesar = ["romain%","crou%","parm%"]
          @caesarwithchicken = ["romain%","crou%","parm%","chicken"]
          @garden = ["tomatoes","mushroom","green pepper","black%"]
          @partygarden = ["tomatoes","mushroom","green pepper","black%"]
          
          @array = []
          
          if a.Name.include? "Chef"
            @chef.each do |item|
              @array.push(Option.where("category_id = ? AND Name like ? AND Name NOT LIKE ?", cat, item, "extra").ids.to_s.delete! '[]')
            end 
          elsif a.Name.include? "Greek"
            @greek.each do |item|
              @array.push(Option.where("category_id = ? AND Name like ? AND Name NOT LIKE ?", cat, item, "extra").ids.to_s.delete! '[]')
            end
          elsif a.Name.include? "Antipasto"
            @anti.each do |item|
              @array.push(Option.where("category_id = ? AND Name like ? AND Name NOT LIKE ?", cat, item, "extra").ids.to_s.delete! '[]')
            end
          elsif a.Name.include? "Grilled"
            @chicken.each do |item|
              @array.push(Option.where("category_id = ? AND Name like ? AND Name NOT LIKE ?", cat, item, "extra").ids.to_s.delete! '[]')
            end
          elsif a.Name.include? "w/ Chicken"
            @caesarwithchicken.each do |item|
              @array.push(Option.where("category_id = ? AND Name like ? AND Name NOT LIKE ?", cat, item, "extra").ids.to_s.delete! '[]')
            end
          elsif a.Name.include? "Caesar"
            @caesar.each do |item|
              @array.push(Option.where("category_id = ? AND Name like ? AND Name NOT LIKE ?", cat, item, "extra").ids.to_s.delete! '[]')
            end
          elsif a.Name.include? "Garden"
            @garden.each do |item|
              @array.push(Option.where("category_id = ? AND Name like ? AND Name NOT LIKE ?", cat, item, "extra").ids.to_s.delete! '[]')
            end
          elsif a.Name.include? "Party"
            @partygarden.each do |item|
              @array.push(Option.where("category_id = ? AND Name like ? AND Name NOT LIKE ?", cat, item, "extra").ids.to_s.delete! '[]')
            end
          else
            @array = []
          end
          
          if !@array.empty?
            a.freeoptions = @array
            a.save!
          end
        end
      else
        Product.where("category_id = ?", cat).each do |a|
          
          @array = []
          
          if !@array.empty?
            a.freeoptions = @array
            a.save!
          end
        end
      end
    end
  end
end