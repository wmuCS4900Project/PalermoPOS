module OrdersHelper
    
  def line_saver(thisorderline, options1, options2, options3, options4)
    
    cost = Product.find(thisorderline.product_id).Cost
    
    if thisorderline.whole?
      if !options1.nil?
        options1.each do |c|
          cost = cost + Option.find(c).Cost
        end
      end
      thisorderline.Options1 = options1
      thisorderline.ItemTotalCost = cost
      thisorderline.save!
      
    elsif thisorderline.halves?
      if !options1.nil?
        options1.each do |a|
          cost = cost + Option.find(a).Cost * 0.5
        end
      end
      thisorderline.Options1 = options1
      if !options2.nil?
        options2.each do |b|
          cost = cost + Option.find(b).Cost * 0.5
        end
      end
      thisorderline.Options2 = options2
      thisorderline.ItemTotalCost = cost
      thisorderline.save!
    
    elsif thisorderline.quarters?
      if !options1.nil?
        options1.each do |a|
          cost = cost + Option.find(a).Cost * 0.25
        end
      end
      thisorderline.Options1 = options1
      if !options2.nil?
        options2.each do |b|
          cost = cost + Option.find(b).Cost * 0.25
        end
      end
      thisorderline.Options2 = options2
      if !options3.nil?
        options3.each do |c|
          cost = cost + Option.find(c).Cost * 0.25
        end
      end
      thisorderline.Options3 = options3
      if !options4.nil?
        options4.each do |d|
          cost = cost + Option.find(d).Cost * 0.25
        end
      end
      thisorderline.Options4 = options4      
      thisorderline.ItemTotalCost = cost
      thisorderline.save!
    
    end
  end
end