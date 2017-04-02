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
              addcost += Option.find(a).Cost * 0.5
            elsif Product.find(thisorderline.product_id).freeoptions.include?(Option.find(a).ChildOf.to_s)
              puts "found a free childof"
              addcost += (Option.find(a).Cost.to_f - Option.find(Option.find(a).ChildOf).Cost.to_f) * 0.5
            else
              puts "found a nonfree childof"
              addcost += Option.find(a).Cost * 0.5
            end
            optioncount += 0.5
          end
        end
      end
      if !options2.nil?
        options2.each do |a|
          if !Product.find(thisorderline.product_id).freeoptions.include?(a)
            if Option.find(a).ChildOf == nil
              puts "found a nil childof"
              addcost += Option.find(a).Cost * 0.5
            elsif Product.find(thisorderline.product_id).freeoptions.include?(Option.find(a).ChildOf.to_s)
              puts "found a free childof"
              addcost += (Option.find(a).Cost.to_f - Option.find(Option.find(a).ChildOf).Cost.to_f) * 0.5
            else
              puts "found a nonfree childof"
              addcost += Option.find(a).Cost * 0.5
            end
            optioncount += 0.5
          end
        end
      end
    
    elsif thisorderline.quarters?
      if !options1.nil?
        options1.each do |a|
          if !Product.find(thisorderline.product_id).freeoptions.include?(a)
            if Option.find(a).ChildOf == nil
              puts "found a nil childof"
              addcost += Option.find(a).Cost * 0.25
            elsif Product.find(thisorderline.product_id).freeoptions.include?(Option.find(a).ChildOf.to_s)
              puts "found a free childof"
              addcost += (Option.find(a).Cost.to_f - Option.find(Option.find(a).ChildOf).Cost.to_f) * 0.25
            else
              puts "found a nonfree childof"
              addcost += Option.find(a).Cost * 0.25
            end
            optioncount += 0.25
          end
        end
      end
      if !options2.nil?
        options2.each do |a|
          if !Product.find(thisorderline.product_id).freeoptions.include?(a)
            if Option.find(a).ChildOf == nil
              puts "found a nil childof"
              addcost += Option.find(a).Cost * 0.25
            elsif Product.find(thisorderline.product_id).freeoptions.include?(Option.find(a).ChildOf.to_s)
              puts "found a free childof"
              addcost += (Option.find(a).Cost.to_f - Option.find(Option.find(a).ChildOf).Cost.to_f) * 0.25
            else
              puts "found a nonfree childof"
              addcost += Option.find(a).Cost * 0.25
            end
            optioncount += 0.25
          end
        end
      end
      if !options3.nil?
        options3.each do |a|
          if !Product.find(thisorderline.product_id).freeoptions.include?(a)
            if Option.find(a).ChildOf == nil
              puts "found a nil childof"
              addcost += Option.find(a).Cost * 0.25
            elsif Product.find(thisorderline.product_id).freeoptions.include?(Option.find(a).ChildOf.to_s)
              puts "found a free childof"
              addcost += (Option.find(a).Cost.to_f - Option.find(Option.find(a).ChildOf).Cost.to_f) * 0.25
            else
              puts "found a nonfree childof"
              addcost += Option.find(a).Cost * 0.25
            end
            optioncount += 0.25
          end
        end
      end
      if !options4.nil?
        options4.each do |a|
          if !Product.find(thisorderline.product_id).freeoptions.include?(a)
            if Option.find(a).ChildOf == nil
              puts "found a nil childof"
              addcost += Option.find(a).Cost* 0.25
            elsif Product.find(thisorderline.product_id).freeoptions.include?(Option.find(a).ChildOf.to_s)
              puts "found a free childof"
              addcost += (Option.find(a).Cost.to_f - Option.find(Option.find(a).ChildOf).Cost.to_f) * 0.25
            else
              puts "found a nonfree childof"
              addcost += Option.find(a).Cost * 0.25
            end
            optioncount += 0.25
          end
        end
      end
    end
    
    puts "optioncount is " + optioncount.to_s
    puts "ceiling is " + optioncount.ceil.to_s
    
    if (optioncount.ceil - optioncount) > 0
      addcost += (optioncount.ceil - optioncount) * Product.find(thisorderline.product_id).MinimumOptionCharge 
      optioncount = optioncount.ceil
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
  #sales tax information based on https://www.legislature.mi.gov/(S(wrwcmwmxg3runuoc5j0udnio))/mileg.aspx?page=getobject&objectName=mcl-205-73
  def calc_order(order_id)
    
    order = Order.find(order_id)
    
    subtotal = 0.0
    
    orderlines = Orderline.where('order_id = ?', order.id)
    
    orderlines.each do |a|
       subtotal += a.ItemTotalCost
    end

    order.Subtotal = subtotal
    
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
    
    taxes += centstax
    
    if order.IsDelivery == true
      if Customer.find(order.customer_id).LongDelivery == true
        dlvcharge = Palconfig.where('name = ?', 'deliverylong').first.val1.to_f
      elsif Customer.find(order.customer_id).LongDelivery == false
        dlvcharge = Palconfig.where('name = ?', 'delivery').first.val1.to_f
      end
    else
      dlvcharge = 0.0
    end
    
    order.DeliveryCharge = dlvcharge

    order.Tax = taxes
    order.TotalCost = order.Subtotal.to_f - order.Discounts + order.Tax + order.DeliveryCharge
    puts order.Subtotal
    puts order.Discounts
    puts order.Tax
    puts order.DeliveryCharge
    puts order.TotalCost
    order.save!
  end
  
  
  def orders_options_update(orderid, pickupordelivery, discount, user, driver, comments)
    
    puts "orders_options_update called"
    
    @order = Order.find(orderid)
    
    if pickupordelivery == 'delivery'
      @order.IsDelivery = true
    else
      @order.IsDelivery = false
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
  #don't touch me
  def coupon_processor(coupon_id, order_id)
    
    puts "called the coupon processor"
    
    @order = Order.find(order_id)
    @orderlines = Orderline.where('order_id = ?', order_id).all.to_a
    puts "items " + @orderlines.inspect
    
    #remove any items from the array for which coupons are already applied to this order, as they cannot count for two separate coupons
    if @order.Coupons != nil
      puts "looking at old coupons"
      @order.Coupons.each do |a|
        @coupon = Coupon.find(a)
        puts "confirming stuff for " + @coupon.Name
        (0..9).each do |b|
          if @coupon.ProductData[b] != ''
            if @coupon.ProductType[b] == '0'
              puts "looking for an exact item " + @coupon.ProductData[b].to_s
              @orderlines.each do |c|
                if c.product_id == @coupon.ProductData[b].to_i
                  puts "found an exact item"
                  if @coupon.ProductMinOptions[b] != ''
                    puts "it needs min options"
                    if @coupon.ProductMinOptions[b].to_f <= c.OptionCount
                      @orderlines.delete(c)
                      puts "it qualifies1v1"
                    end
                  else
                    @orderlines.delete(c)
                    puts "it qualifies1v2"
                  end
                else
                  puts "didnt find it 1"
                end
              end
            elsif @coupon.ProductType[b] == '1'
              puts "looking for a category item " + @coupon.ProductData[b].to_s
              @orderlines.each do |c|
                if Product.find(c.product_id).category_id == @coupon.ProductData[b].to_i
                  puts "found a category item"
                  if @coupon.ProductMinOptions[b] != ''
                    puts "it needs min options"
                    if @coupon.ProductMinOptions[b].to_f <= c.OptionCount
                      @orderlines.delete(c)
                      puts "it qualifies 2v1"
                    end
                  else
                    @orderlines.delete(c)
                    puts "it qualifies 2v2"
                  end
                else
                  puts "didn't find it 2"
                end
              end
            elsif @coupon.ProductType[b] == '2'
              puts "looking for a string match" + @coupon.ProductData[b].to_s
              @orderlines.each do |c|
                if Product.find(c.product_id).Name.include?(@coupon.ProductData[b])
                  puts "found a string match"
                  if @coupon.ProductMinOptions[b] != ''
                    puts "it needs min options"
                    if @coupon.ProductMinOptions[b].to_f <= c.OptionCount
                      @orderlines.delete(c)
                      puts "it qualifies 3v1"
                    end
                  else
                    @orderlines.delete(c)
                    puts "it qualifies 3v2"
                  end
                else
                  puts "didnt find it 3"
                end
              end
            end
          end
        end
      end
    end
    
    puts @orderlines.inspect
    
    
    @coupon_new = Coupon.find(coupon_id)
    
    found = false
    
    puts "dealing with new coupon"
    (0..9).each do |b|
      found = false
      if @coupon_new.ProductData[b] != ''
        puts "looking for a product"
        if @coupon_new.ProductType[b] == '0'
          puts "looking for an exact item " + @coupon_new.ProductData[b].to_s
          @orderlines.each do |c|
            puts "looking at " + Product.find(c.product_id).Name
            if c.product_id == @coupon_new.ProductData[b].to_i
              puts "found an exact item"
              if @coupon_new.ProductMinOptions[b] != ''
                puts "it needs min options"
                if @coupon_new.ProductMinOptions[b].to_f <= c.OptionCount
                  @orderlines.delete(c)
                  found = true
                  puts "found it 1v1"
                else
                  puts "coupon wants " + @coupon_new.ProductMinOptions[b]
                  puts "has " + c.OptionCount.to_s
                  puts "not enough options"
                end
              else
                @orderlines.delete(c)
                found = true
                puts "found it 1v2"
              end
            else
              puts "didnt find it 1"
            end
          end
        elsif @coupon_new.ProductType[b] == '1'
          puts "looking for a category item " + @coupon_new.ProductData[b].to_s
          @orderlines.each do |c|
            puts "looking at " + Product.find(c.product_id).Name
            if Product.find(c.product_id).category_id == @coupon_new.ProductData[b].to_i
              if @coupon_new.ProductMinOptions[b] != ''
                puts "it needs min options"
                if @coupon_new.ProductMinOptions[b].to_f <= c.OptionCount
                  @orderlines.delete(c)
                  found = true
                  puts "found it 2v1"
                else
                  puts "coupon wants " + @coupon_new.ProductMinOptions[b]
                  puts "has " + c.OptionCount.to_s
                  puts "not enough options"
                end
              else
                @orderlines.delete(c)
                found = true
                puts "found it 2v2"
              end
            else
              puts "didnt find it"
            end
          end
        elsif @coupon_new.ProductType[b] == '2'
          puts "looking for a string match " + @coupon_new.ProductData[b].to_s
          @orderlines.each do |c|
            puts "looking at " + Product.find(c.product_id).Name
            if Product.find(c.product_id).Name.include?(@coupon_new.ProductData[b])
              if @coupon_new.ProductMinOptions[b] != ''
                puts "it needs min options"
                if @coupon_new.ProductMinOptions[b].to_f <= c.OptionCount
                  @orderlines.delete(c)
                  found = true
                  puts "found it 3v1"
                else
                  puts "coupon wants " + @coupon_new.ProductMinOptions[b]
                  puts "has " + c.OptionCount.to_s
                  puts "not enough options"
                end
              else
                @orderlines.delete(c)
                found = true
                puts "found it 3v2"
              end
            else
              puts "didnt find it 3"
            end
          end
        end
      else
        found = true
      end
      
      if found == false
        return false
      end
    end
      
      if found == true
        puts "returning true"
        return true
      else
        puts "returning false"
        return false
      end
  end
    
end