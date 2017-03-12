module OrdersHelper
    
  def line_saver(thisorderline, options1, options2, options3, options4)
    
    cost = Product.find(thisorderline.product_id).Cost
    addcost = 0.0
    
    optioncount = 0.0
    
    if thisorderline.whole?
      if !options1.nil?
        options1.each do |a|
          if !Product.find(thisorderline.product_id).freeoptions.include?(a)
            if Option.find(a).ChildOf == nil
              puts "found a nil childof"
              addcost += Option.find(a).Cost
            elsif Product.find(thisorderline.product_id).freeoptions.include?(Option.find(a).ChildOf.to_s)
              puts "found a free childof"
              addcost += (Option.find(a).Cost.to_f - Option.find(Option.find(a).ChildOf).Cost.to_f)
            else
              puts "found a nonfree childof"
              addcost += Option.find(a).Cost
            end
            optioncount += 1.0
          end
        end
      end
      
    elsif thisorderline.halves?
      if !options1.nil?
        options1.each do |a|
          if !Product.find(thisorderline.product_id).freeoptions.include?(a)
            if Option.find(a).ChildOf == nil
              puts "found a nil childof"
              addcost += Option.find(a).Cost
            elsif Product.find(thisorderline.product_id).freeoptions.include?(Option.find(a).ChildOf.to_s)
              puts "found a free childof"
              addcost += (Option.find(a).Cost.to_f - Option.find(Option.find(a).ChildOf).Cost.to_f)
            else
              puts "found a nonfree childof"
              addcost += Option.find(a).Cost
            end
            optioncount += 1.0
          end
        end
      end
      if !options2.nil?
        options2.each do |a|
          if !Product.find(thisorderline.product_id).freeoptions.include?(a)
            if Option.find(a).ChildOf == nil
              puts "found a nil childof"
              addcost += Option.find(a).Cost
            elsif Product.find(thisorderline.product_id).freeoptions.include?(Option.find(a).ChildOf.to_s)
              puts "found a free childof"
              addcost += (Option.find(a).Cost.to_f - Option.find(Option.find(a).ChildOf).Cost.to_f)
            else
              puts "found a nonfree childof"
              addcost += Option.find(a).Cost
            end
            optioncount += 1.0
          end
        end
      end
    
    elsif thisorderline.quarters?
      if !options1.nil?
        options1.each do |a|
          if !Product.find(thisorderline.product_id).freeoptions.include?(a)
            if Option.find(a).ChildOf == nil
              puts "found a nil childof"
              addcost += Option.find(a).Cost
            elsif Product.find(thisorderline.product_id).freeoptions.include?(Option.find(a).ChildOf.to_s)
              puts "found a free childof"
              addcost += (Option.find(a).Cost.to_f - Option.find(Option.find(a).ChildOf).Cost.to_f)
            else
              puts "found a nonfree childof"
              addcost += Option.find(a).Cost
            end
            optioncount += 1.0
          end
        end
      end
      if !options2.nil?
        options2.each do |a|
          if !Product.find(thisorderline.product_id).freeoptions.include?(a)
            if Option.find(a).ChildOf == nil
              puts "found a nil childof"
              addcost += Option.find(a).Cost
            elsif Product.find(thisorderline.product_id).freeoptions.include?(Option.find(a).ChildOf.to_s)
              puts "found a free childof"
              addcost += (Option.find(a).Cost.to_f - Option.find(Option.find(a).ChildOf).Cost.to_f)
            else
              puts "found a nonfree childof"
              addcost += Option.find(a).Cost
            end
            optioncount += 1.0
          end
        end
      end
      if !options3.nil?
        options3.each do |a|
          if !Product.find(thisorderline.product_id).freeoptions.include?(a)
            if Option.find(a).ChildOf == nil
              puts "found a nil childof"
              addcost += Option.find(a).Cost
            elsif Product.find(thisorderline.product_id).freeoptions.include?(Option.find(a).ChildOf.to_s)
              puts "found a free childof"
              addcost += (Option.find(a).Cost.to_f - Option.find(Option.find(a).ChildOf).Cost.to_f)
            else
              puts "found a nonfree childof"
              addcost += Option.find(a).Cost
            end
            optioncount += 1.0
          end
        end
      end
      if !options4.nil?
        options4.each do |a|
          if !Product.find(thisorderline.product_id).freeoptions.include?(a)
            if Option.find(a).ChildOf == nil
              puts "found a nil childof"
              addcost += Option.find(a).Cost
            elsif Product.find(thisorderline.product_id).freeoptions.include?(Option.find(a).ChildOf.to_s)
              puts "found a free childof"
              addcost += (Option.find(a).Cost.to_f - Option.find(Option.find(a).ChildOf).Cost.to_f)
            else
              puts "found a nonfree childof"
              addcost += Option.find(a).Cost
            end
            optioncount += 1.0
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
  
  #order totals calculator, handles subtotalling, coupons, discounts, taxes, and totalling
  def calc_taxes(orderid)
    
    order = Order.find(orderid)
    
    coupondiscount = 0.0
    if !order.Coupons.nil?
      puts "figuring out coupon discounts"
      puts order.Coupons.inspect
      order.Coupons.each do |a|
        if Coupon.find(a).dollars?
          puts "adding a thing"
          coupondiscount += Coupon.find(a).DollarsOff
        elsif Coupon.find(a).percent?
          puts "percent"
        #TODO add some kind of percent off logic
        end
      end
    end
    puts coupondiscount.inspect
    order.Discounts = coupondiscount + order.ManualDiscount
    
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
  
  def orders_options_update(orderid, pickupordelivery, discount, user, driver, comments)
    
    puts "orders_options_update called"
    
    @order = Order.find(orderid)
    
    if !pickupordelivery.nil? 
      if pickupordelivery == "delivery"
        @order.IsDelivery = true
        if Customer.find(@order.customer_id).LongDelivery == true
          @order.TotalCost = @order.TotalCost + Rails.configuration.palermo['deliveryLong']
        else
          @order.TotalCost = @order.TotalCost + Rails.configuration.palermo['deliveryShort']
        end
      elsif pickupordelivery == "pickup"
        @order.IsDelivery = false
      end
      
    end
    
    if !discount.nil?
      @order.ManualDiscount = discount
    end
    
    if !user.nil?
      @order.user_id = user
    end
    
    if !driver.nil?
      @order.DriverID = driver
    end
    
    if !comments.nil?
      @order.Comments = comments
    end
    
    @order.save!
    
  end
  
  #runs through products on an order and determines if the selected coupon(s) can be applied or not
  def coupon_processor(coupon_id, order_id)
    
    puts "called the coupon processor"
    
    @order = Order.find(order_id)
    items = []
    Orderline.where('order_id = ?', order_id).each do |this| #add product ids to the items array for use to compare with coupon requirements
      items.push(this.product_id)
    end
    puts "items " + items.inspect
    
    #remove any items from the array for which coupons are already applied to this order, as they cannot count for two separate coupons
    if @order.Coupons != nil
      puts "found coupons existing"
      @order.Coupons.each do |a|
        @coupon = Coupon.find(a)
        @coupon.Requirements.each do |b|
          if items.include?(b.to_i)
            puts "trying to delete " + b
            items.delete_at(items.index(b.to_i) || items.length)
          end
          puts "items has " + items.inspect
        end
        @coupon.Requirements2.each do |b|
          items.each do |c|
            if Product.find(c).category_id == b.to_i
              items.delete_at(items.index(c) || items.length)
              puts "trying to delete " + c.to_s
            end
          end
          puts "items has " + items.inspect
        end
      end
    end
    
    #if there's still any items, lets compare them with the coupon trying to apply
    @coupon_new = Coupon.find(coupon_id)
    puts "items2 " + items.inspect
    
    if items.size > 0
      matched = false
      puts "Reqs " + @coupon_new.Requirements.inspect
      @coupon_new.Requirements.each do |a|
        puts "trying to find a " + a.inspect
        if !a.nil? && a != ''
          matched = false
          puts "items3 " + items.inspect
          items.each do |b|
            if b == a.to_i
              items.delete_at(items.index(b) || items.length)
              puts "trying to delete " + b.to_s
              matched = true
            end
          end
        end
      end
      if matched == false
          puts "returning false1"
          return false
      end
      @coupon_new.Requirements2.each do |a|
        puts "trying to find a " + a.inspect
        if !a.nil? && a != ''
          matched = false
          puts "items3 " + items.inspect
          items.each do |b|
            if Product.find(b).category_id == a.to_i
              items.delete_at(items.index(b) || items.length)
              puts "trying to delete " + b.to_s
              matched = true
            end
          end
        end
      end
      if matched == false
          puts "returning false1"
          return false
      end
    else #no items left to check against coupon? failed to apply coupon
      puts "returning false2"
      return false
    end
      
    #made it this far? coupon can be applied
    puts "returning true"
    return true
      
  end
    
end