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
  
  def calc_taxes(orderid)
    
    order = Order.find(orderid)
    
    subtotal2 = order.Subtotal.to_f - order.Discounts
    cashsplit = subtotal2.divmod 1
    taxes = 0.0
    centstax = 0.0
    taxes = (cashsplit[0] * 0.06)
    
    if((0.10 >= cashsplit[1]) && (cashsplit[1] >= 0.00))
      centstax = 0.0
    elsif((0.24 >= cashsplit[1]) && (cashsplit[1] >= 0.11))
      centstax = 0.01
    elsif((0.41 >= cashsplit[1]) && (cashsplit[1] >= 0.25))
      centstax = 0.02
    elsif((0.58 >= cashsplit[1]) && (cashsplit[1] >= 0.42))
      centstax = 0.03    
    elsif((0.74 >= cashsplit[1]) && (cashsplit[1] >= 0.59))
      centstax = 0.04    
    elsif((0.91 >= cashsplit[1]) && (cashsplit[1] >= 0.75))
      centstax = 0.05
    elsif((0.99 >= cashsplit[1]) && (cashsplit[1] >= 0.92))
      centstax = 0.06      
    end
    
    taxes = taxes + centstax
    
    order.Tax = taxes
    order.TotalCost = order.Subtotal.to_f - order.Discounts + order.Tax
    order.save!
  end
end