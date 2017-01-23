module OrdersHelper
    
  def line_saver(thisorderline, options1, options2, options3, options4)
    
    cost = Product.find(thisorderline.product_id).Cost
    addcost = 0.0
    
    optioncount = 0.0
    
    if thisorderline.whole?
      if !options1.nil?
        options1.each do |a|
          if !Product.find(thisorderline.product_id).freeoptions.include?(a)
            addcost = addcost + Option.find(a).Cost
            optioncount = optioncount + 1.0
          end
        end
      end
      
    elsif thisorderline.halves?
      if !options1.nil?
        options1.each do |a|
          if !Product.find(thisorderline.product_id).freeoptions.include?(a)
            addcost = addcost + Option.find(a).Cost * 0.5
            optioncount = optioncount + 0.5
          end
        end
      end
      if !options2.nil?
        options2.each do |b|
          if !Product.find(thisorderline.product_id).freeoptions.include?(b)
            addcost = addcost + Option.find(b).Cost * 0.5
            optioncount = optioncount + 0.5
          end
        end
      end
    
    elsif thisorderline.quarters?
      if !options1.nil?
        options1.each do |a|
          if !Product.find(thisorderline.product_id).freeoptions.include?(a)
            cost = cost + Option.find(a).Cost * 0.25
            optioncount = optioncount + 0.25
          end
        end
      end
      if !options2.nil?
        options2.each do |b|
          if !Product.find(thisorderline.product_id).freeoptions.include?(b)
            cost = cost + Option.find(b).Cost * 0.25
            optioncount = optioncount + 0.25
          end
        end
      end
      if !options3.nil?
        options3.each do |c|
          if !Product.find(thisorderline.product_id).freeoptions.include?(c)
            cost = cost + Option.find(c).Cost * 0.25
            optioncount = optioncount + 0.25
          end
        end
      end
      if !options4.nil?
        options4.each do |d|
          if !Product.find(thisorderline.product_id).freeoptions.include?(d)
            cost = cost + Option.find(d).Cost * 0.25
            optioncount = optioncount + 0.25
          end
        end
      end
    end

    if addcost > 0 && addcost < Product.find(thisorderline.product_id).MinimumOptionCharge
      addcost = Product.find(thisorderline.product_id).MinimumOptionCharge
    end
    
    thisorderline.OptionCount = optioncount
    thisorderline.Options1 = options1
    thisorderline.Options2 = options2
    thisorderline.Options3 = options3
    thisorderline.Options4 = options4
    thisorderline.ItemTotalCost = cost + addcost
    thisorderline.save!
    
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