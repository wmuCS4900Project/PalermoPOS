class OrdersController < ApplicationController
  before_action :set_order, only: [:show, :edit, :update, :destroy]
  
  include OrdersHelper

  # GET /orders
  # GET /orders.json
  def index
    flash.keep
    if ( !logged_in? || !current_user.can?("view", "orders"))
      redirect_to default_index_url, :flash => { :danger => "You do not have permission to do this!" }
      return
    end
      
    @customers = Customer.all
    @pending = Order.where("PaidFor IS false AND Cancelled IS false AND Refunded IS false AND created_at BETWEEN ? AND ?", DateTime.now.beginning_of_day, DateTime.now.end_of_day).all
    @cancelled = Order.where("Cancelled IS true AND created_at BETWEEN ? AND ?", DateTime.now.beginning_of_day, DateTime.now.end_of_day).all
    @completed = Order.where("PaidFor IS true AND created_at BETWEEN ? AND ?", DateTime.now.beginning_of_day, DateTime.now.end_of_day).all
    @refunded = Order.where(id: Refund.pluck(:order_id)).where("created_at BETWEEN ? AND ?", DateTime.now.beginning_of_day, DateTime.now.end_of_day)
  end
  
  def pickup
    if ( !logged_in? || !current_user.can?("view", "orders"))
      redirect_to default_index_url, :flash => { :danger => "You do not have permission to do this!" }
      return
    end
    
    @customers = Customer.all
    @orders = Order.where("PaidFor IS false AND Cancelled IS false AND Refunded IS false AND IsDelivery IS false AND created_at BETWEEN ? AND ?", DateTime.now.beginning_of_day, DateTime.now.end_of_day).all
  end
  
  def delivery
    if ( !logged_in? || !current_user.can?("view", "orders"))
      redirect_to default_index_url, :flash => { :danger => "You do not have permission to do this!" }
      return
    end
    
    @customers = Customer.all
    @orders = Order.where("PaidFor IS false AND Cancelled IS false AND Refunded IS false AND IsDelivery IS true AND created_at BETWEEN ? AND ?", DateTime.now.beginning_of_day, DateTime.now.end_of_day).all
  end
  
  def oldorders
    if ( !logged_in? || !current_user.can?("view", "orders"))
      redirect_to default_index_url, :flash => { :danger => "You do not have permission to do this!" }
      return
    end
    
    if !params[:startdate].present? && !params[:enddate].present? && !params[:thisdate].present?
      render :oldorders
      return
    end
    
    if params[:thisdate].present?
      @year = params[:thisdate]['(1i)'].to_s
      @month = params[:thisdate]['(2i)'].to_s
      @day = params[:thisdate]['(3i)'].to_s
      @date = @year + '-' + @month + '-' + @day
      @customers = Customer.all
      @pending = Order.where("PaidFor IS false AND Cancelled IS false AND Refunded IS false AND DATE(created_at) = ?", @date).all.limit(500)
      @completed = Order.where("PaidFor IS true AND Cancelled IS false AND Refunded IS false AND DATE(created_at) = ?", @date).all.limit(500)
      @cancelled = Order.where("PaidFor IS false AND Cancelled IS true AND Refunded IS false AND DATE(created_at) = ?", @date).all.limit(500)
      @refunded = Order.where("PaidFor IS true AND Cancelled IS false AND Refunded IS true AND DATE(created_at) = ?", @date).all.limit(500)
      return
    end
    
    if params[:startdate].present? && params[:enddate].present?
      @year = params[:startdate]['(1i)'].to_s
      @month = params[:startdate]['(2i)'].to_s
      @day = params[:startdate]['(3i)'].to_s
      @date1 = @year + '-' + @month + '-' + @day
      @year = params[:enddate]['(1i)'].to_s
      @month = params[:enddate]['(2i)'].to_s
      @day = params[:enddate]['(3i)'].to_s
      @date2 = @year + '-' + @month + '-' + @day
      @customers = Customer.all
      @pending = Order.where("PaidFor IS false AND Cancelled IS false AND Refunded IS false AND DATE(created_at) >= ? AND DATE(created_at) <= ?", @date1, @date2).all.limit(500)
      @completed = Order.where("PaidFor IS true AND Cancelled IS false AND Refunded IS false AND DATE(created_at) >= ? AND DATE(created_at) <= ?", @date1, @date2).all.limit(500)
      @cancelled = Order.where("PaidFor IS false AND Cancelled IS true AND Refunded IS false AND DATE(created_at) >= ? AND DATE(created_at) <= ?", @date1, @date2).all.limit(500)
      @refunded = Order.where("PaidFor IS true AND Cancelled IS false AND Refunded IS true AND DATE(created_at) >= ? AND DATE(created_at) <= ?", @date1, @date2).all.limit(500)
      return
    end
    
  end
  
  #in-between for editting orders so we can check "edit" and "orders" in caps while keeping the actual order functions under "create"
  def changeorder
    if ( !logged_in? || !current_user.can?("edit", "orders"))
      redirect_to default_index_url, :flash => { :danger => "You do not have permission to do this!" }
      return
    end
    
    if !params[:order_id].present?
      redirect_to orders_path, :flash => { :notice => "No current order!" }
      return
    end
    redirect_to controller: 'orders', action: 'selectproduct', order_id: params[:order_id]
  end
  
  def selectproduct
    if ( !logged_in? || !current_user.can?("create", "orders"))
      redirect_to default_index_url, :flash => { :danger => "You do not have permission to do this!" }
      return
    end
    
    if !params[:order_id].present?
      redirect_to orders_path, :flash => { :notice => "No current order!" }
      return
    end
    @order = Order.find(params[:order_id])
    @categories = Category.all
  end
  
  #creates a new product when selected on the orders page
  def addproducttoorder
    if ( !logged_in? || !current_user.can?("create", "orders"))
      redirect_to default_index_url, :flash => { :danger => "You do not have permission to do this!" }
      return
    end
    
    if !params[:order_id].present?
      redirect_to orders_path, :flash => { :notice => "No current order!" }
      return
    elsif !params[:product_id].present?
      redirect_to orders_path, :flash => { :notice => "No product selected!" }
      return
    end
    
    @order = Order.find(params[:order_id])
    
    @product = Product.find(params[:product_id])
    @orderline = Orderline.create :product_id => @product.id, :order_id => @order.id, :ItemTotalCost => @product.Cost
    
    calc_order(@order.id)
      
    redirect_to orders_chooseoptions_path(order_id: @order.id, orderline_id: @orderline.id)
    return
  end
  
  def commitorder
    if ( !logged_in? || !current_user.can?("create", "orders"))
      redirect_to orders_path, :flash => { :danger => "You do not have permission to do this!" }
      return
    end
    
    if !params[:order_id].present?
      redirect_to orders_path, :flash => { :notice => "No current order!" }
      return
    end 
    
    calc_order(params[:order_id])
    
    @orderid = params[:order_id]
    @pickup = params[:pickupordeliveryouter]
    @discount = params[:discount]
    @user = params[:user_id]
    @driver = params[:driver_id]
    @comments = params[:comments]

    orders_options_update(@orderid, @pickup, @discount, @user, @driver, @comments)
    calc_order(params[:order_id])

    if params['commit'] == "Submit Order & Print"
      redirect_to orders_receipt_url(id: @order.id)
      return
    else
      redirect_to orders_url, :flash => { :notice => 'Order created!' }
      return
    end

  end
  
  def selectcoupons
    if ( !logged_in? || !current_user.can?("create", "orders"))
      redirect_to orders_path, :flash => { :danger => "You do not have permission to do this!" }
      return
    end
    
    if !params[:order_id].present?
      redirect_to orders_path, :flash => { :notice => "No current order!" }
      return
    end
    
    @order = Order.find(params[:order_id])
  end
  
  def addcoupons
    if ( !logged_in? || !current_user.can?("create", "orders"))
      redirect_to orders_path, :flash => { :danger => "You do not have permission to do this!" }
      return
    end
    
    if !params[:order_id].present?
      redirect_to orders_path, :flash => { :notice => "No current order!" }
      return
    end
    if !params[:cid].present?
      redirect_to orders_selectproduct_path(order_id: @order.id), :flash => { :notice => "No coupon selected!" } 
      return
    end
    
    @order = Order.find(params[:order_id])
    
    if params[:cid] == "clear"
      @order.Coupons = nil
      flash[:notice] = 'Coupons removed!'
    else
      @ret = coupon_processor(params[:cid],@order.id)
      
      if @ret == true
        if !@order.Coupons.nil?
          @coupons = @order.Coupons
        else
          @coupons = []
        end
        
        @coupons.push(params[:cid])
        @order.Coupons = @coupons
        
        flash[:notice] = 'Coupon added!'
      else
        flash[:notice] = 'Order inelligible for coupon!'
      end
      
    end
    
    @order.save!
    
    calc_order(@order.id)
    
    redirect_to orders_selectproduct_path(order_id: @order.id)
    return
  end
  
  #a workaround to recalculate the order total if you delete an orderline
  def recalcForOrderlineDelete
    if ( !logged_in? || !current_user.can?("delete", "orderlines"))
      redirect_to orders_path, :flash => { :danger => "You do not have permission to do this!" }
      return
    end
    
    @order = Order.find(params[:order_id])

    @order.Coupons = nil

    calc_order(@order.id)
    
    redirect_to orders_selectproduct_path(:order_id => @order.id), :flash => { :notice => 'Order line deleted and coupons removed!' }
    return
  end
  
  #view handles selection of options for an orderline
  def chooseoptions
    if ( !logged_in? || !current_user.can?("create", "orders"))
      redirect_to orders_path, :flash => { :danger => "You do not have permission to do this!" }
      return
    end
    
    if !params[:order_id].present?
      redirect_to orders_path, :flash => { :notice => "No current order!" }
      return
    elsif !params[:orderline_id].present?
      redirect_to orders_path, :flash => { :notice => "No line selected!" }
      return
    end
    
    @order = Order.find(params[:order_id])
    @orderline = Orderline.find(params[:orderline_id])
    @product = Product.find(@orderline.product_id)
    @options = Option.where("category_id = ?", @product.category_id).all
    
    #direct back if there's no options in this category
    if @options.nil? || @options.size < 1
      calc_order(@order.id)
      redirect_to orders_selectproduct_path(order_id: @order.id), :flash => { :notice => "Item added to order!" }
      return
    end
      
    @ops1 = "options1[]"
    @ops2 = "options2[]"
    @ops3 = "options3[]"
    @ops4 = "options4[]"
  end
  
  #saves any options selected in the chooseoptions view
  def addoptions
    if ( !logged_in? || !current_user.can?("create", "orders"))
      redirect_to orders_path, :flash => { :danger => "You do not have permission to do this!" }
      return
    end
    
    if !params[:order_id].present?
      redirect_to orders_path, :flash => { :notice => "No current order!" }
      return
    elsif !params[:orderline_id].present?
      redirect_to orders_path, :flash => { :notice => "No line selected!" }
      return
    end

    @order = Order.find(params[:order_id])
    @orderline = Orderline.find(params[:orderline_id])
    
    if params[:howcooked].present?
      @orderline.HowCooked = params[:howcooked]
    end
    
    if params[:comments].present?
      @orderline.Comments = params[:comments]
    end
    
    if(Category.find(Product.find(@orderline.product_id).category_id).Splits == false)
      @orderline.splitstyle = :whole
    elsif params[:splitstyle] == "whole"
      @orderline.splitstyle = :whole
    elsif params[:splitstyle] == "halves"
      @orderline.splitstyle = :halves
    elsif params[:splitstyle] == "quarters"
      @orderline.splitstyle = :quarters
    end
    @orderline.save!
    
    if(@orderline.whole?)
      line_saver(@orderline, params[:options1], nil, nil, nil)
    elsif(@orderline.halves?)
      line_saver(@orderline, params[:options1], params[:options2], nil, nil)
    elsif(@orderline.quarters?)
      line_saver(@orderline, params[:options1], params[:options2], params[:options3], params[:options4])
    end
      
    calc_order(@order.id)
    redirect_to orders_selectproduct_path(order_id: @order.id), :flash => { :notice => "Item saved!" }
    return
  end
  
  #adds the orderlines from the previously placed order to the current order. no check for paid/cancelled/refunded status
  def addPreviousOrderItems
    if ( !logged_in? || !current_user.can?("create", "orders"))
      redirect_to orders_path, :flash => { :danger => "You do not have permission to do this!" }
      return
    end
    
    if !params[:order_id].present?
      redirect_to orders_path, :flash => { :notice => "No order selected!" }
      return
    end
    
    @order = Order.find(params[:order_id])
    @customer = Customer.find(@order.customer_id)
    
    @orders = Order.where('customer_id = ?', @customer.id).all
    @orders = @orders.order(:created_at)
    @last = @orders[-2]
    
    if @last.nil?
      redirect_to orders_selectproduct_path(order_id: @order.id), :flash => { :notice => "No previous order!" }
      return
    end
    
    @orderlines = Orderline.where('order_id = ?', @last.id).all
    
    if @orderlines.nil?
      redirect_to orders_selectproduct_path(order_id: @order.id), :flash => { :notice => "No previous items!" }
      return
    end
    
    @orderlines.each do |a|
      @newline = a.dup
      @newline.order_id = @order.id
      @newline.save!
    end
  
    calc_order(@order.id)
    
    redirect_to orders_selectproduct_path(order_id: @order.id), :flash => { :notice => "Items added to order!" }
    return
    
  end
  
  def all
    if ( !logged_in? || !current_user.can?("view", "orders"))
      redirect_to default_index_url, :flash => { :danger => "You do not have permission to do this!" }
      return
    end
    
    @customers = Customer.all
    @pending = Order.where("PaidFor IS false AND Cancelled IS false AND Refunded IS false")
    @cancelled = Order.where("Cancelled IS true")
    @completed = Order.where("PaidFor IS true")
    @refunded = Order.where("Refunded IS true")
  end

  # GET /orders/1
  # GET /orders/1.json
  def show
    if ( !logged_in? || !current_user.can?("view", "orders"))
      redirect_to default_index_url, :flash => { :danger => "You do not have permission to do this!" }
      return
    end
    
    @order = Order.find(params[:id])
    @customers = Customer.all
    @orderlines = Orderline.where("order_id = ?",@order.id).all
    @products = Product.all
    @options = Option.all
  end

  
  # GET /orders/custsearch
  #first step in creating a new order. page includes a "walk in customer" button. calls itself again for a search, displaying results
  def custsearch
    if ( !logged_in? || !current_user.can?("create", "orders"))
      redirect_to orders_path, :flash => { :danger => "You do not have permission to do this!" }
      return
    end
    
    @users = User.all
    c = params[:criteria]
    crit = params[:searchcriteria]
    
    @selected_user_id = params[:user_id]
    
    @results = []

    if crit == "phone"
      @results = Customer.where("Phone like ?", "%#{c}%").limit(100)
    elsif crit == "name"
      r1 = Customer.where("FirstName like ?", "%#{c}%").limit(100)
      r2 = Customer.where("LastName like ?", "%#{c}%").limit(100)
      @results = r1 + r2
    elsif crit == "address"
      r1 = Customer.where("AddressNumber like ?", "%#{c}%").limit(100)
      r2 = Customer.where("StreetName like ?", "%#{c}%").limit(100)
      @results = r1 + r2
    elsif crit == "city"
      @results = Customer.where("City like ?", "%#{c}%").limit(100)
    elsif crit == "zip"
      @results = Customer.where("Zip like ?", "%#{c}%").limit(100)
    end
    
    @results = @results.uniq{|x| x.id}
  end

  # GET /orders/1/edit
  def edit
  end
  
  # GET /orders/walkin
  def walkin
    if ( !logged_in? || !current_user.can?("create", "orders"))
      redirect_to orders_path, :flash => { :danger => "You do not have permission to do this!" }
      return
    end
    
    if Customer.exists?(lastname: 'Customer', firstname:  'Walk In')
      walk_in = Customer.where(lastname: 'Customer', firstname:  'Walk In').first
      params[:custid] = walk_in.id
      params[:mode] = "pickup"
      startorder
    else
      redirect_to orders_custsearch_path, :flash => { :danger => "No walk in customer in database"}
      return
    end
  end

  # GET /orders/startorder
  #when a customer is selected, this runs to create the order before giving any order options in the selectproduct view
  def startorder
    if ( !logged_in? || !current_user.can?("create", "orders"))
      redirect_to orders_path, :flash => { :danger => "You do not have permission to do this!" }
      return
    end
    
    @o = Order.where("created_at BETWEEN ? AND ?", DateTime.now.beginning_of_day, DateTime.now.end_of_day).last
    if @o.nil?
      @daily = 1
    else
      @daily = @o.DailyID + 1
    end
    
    if params[:custid].present?
      if params[:mode].present?
        if params[:mode] == 'pickup'
          @order = Order.create :PaidFor => false, :user_id => User.first.id, :IsDelivery => false, :customer_id => params[:custid], :DailyID => @daily
        elsif params[:mode] == 'delivery'
          @order = Order.create :PaidFor => false, :user_id => User.first.id, :IsDelivery => true, :customer_id => params[:custid], :DailyID => @daily
        end
      else
        @order = Order.create :PaidFor => false, :user_id => User.first.id, :customer_id => params[:custid], :DailyID => @daily
      end
      redirect_to orders_selectproduct_path(order_id: @order.id)
      return
    else
      redirect_to orders_path, :flash => { :notice => "No customer selected!" }    
      return
    end
  end
  
  #get receipt
  #handles display and auto-print for receipt printer
  def receipt
    if ( !logged_in? || !current_user.can?("view", "orders"))
      redirect_to default_index_url, :flash => { :danger => "You do not have permission to do this!" }
      return
    end
    
    @order = Order.find(params[:id])
    @products = Product.all
    @options = Option.all
    @categories = Category.all
    
    if params[:print].present?
      @print = false
    else
      @print = true
      flash[:notice] = 'Order created!'
    end
    
    @customers = Customer.all
    @orderlines = Orderline.where("order_id = ?",@order.id).all
  end

  #generates the cashout page for an order. calls itself over and over to handle tips, adjustments, or coupons if they are added.
  def cashout
    if ( !logged_in? || !current_user.can?("create", "orders"))
      redirect_to orders_path, :flash => { :danger => "You do not have permission to do this!" }
      return
    end
    
    if !params[:id].present?
      redirect_to orders_url, :flash => { :notice => "No order selected." }
      return
    end
    
    @order = Order.find(params[:id])
    @products = Product.all
    
    @customer = Customer.find(@order.customer_id)
    @orderlines = Orderline.where(order_id: @order.id).all
    
  end
  
  #displays final cashout amounts including change and tip
  def cashedout
    if ( !logged_in? || !current_user.can?("create", "orders"))
      redirect_to orders_path, :flash => { :danger => "You do not have permission to do this!" }
      return
    end
    
    if !params[:order_id].present?
      redirect_to orders_url, :flash => { :notice => "Order not found!" }
      return
    end
    if !params[:amountpaid].present?
      redirect_to orders_cashout_url(id: params[:order_id]), :flash => { :notice => "No amount entered!" }
      return
    end
    
    @order = Order.find(params[:order_id])
    
    if @order.PaidFor == true
      redirect_to orders_url, :flash => { :notice => "This order has already been cashed out!" }
    end
    
    if @order.IsDelivery?
      if !params[:order][:DriverID].present?
        redirect_to orders_cashout_url(id: params[:order_id]), :flash => { :notice => "No driver selected!" }
        return
      else
        @order.DriverID = params[:order][:DriverID]
        @order.save!
      end
    end
    
    @customer = Customer.find(@order.customer_id)
    @orderlines = Orderline.where(order_id: @order.id)
    @products = Product.all
    
    @paid = (params[:amountpaid].to_f) / 100
    puts @paid
    puts @paid.to_d
    puts @order.TotalCost
    puts params["commit"].inspect
    @commit = params["commit"]
    
    if @paid.to_d < @order.TotalCost
      puts "checking under"
      redirect_to orders_cashout_url(id: params[:order_id]), :flash => { :notice => "Not enough to cover cost!" }
      puts "not enough"
      return
    elsif @paid.to_d > @order.TotalCost
      puts "checking greater"
      if @commit.downcase.include?("credit")
        puts "found credit"
        if !@order.IsDelivery?
          puts "overpay credit pickup"
          redirect_to orders_cashout_url(id: params[:order_id]), :flash => { :notice => "Can't overpay with credit for pickup!" }
          return
        else
          puts "overpay credit delivery"
          @order.AmountPaid = @paid
          @order.Tip = @order.AmountPaid - @order.TotalCost
          @order.PaidFor = true
          @order.PaidCash = false
        end
      elsif @commit.downcase.include?("cash")
        puts "found cash"
        if @order.IsDelivery? && @commit.downcase.include?("tip")
          puts "overpay cash delivery"
          @order.AmountPaid = @paid
          @order.Tip = @order.AmountPaid - @order.TotalCost
          @order.PaidFor = true
          @order.PaidCash = true
        else
          puts "overpay cash pickup"
          @order.AmountPaid = @paid
          @order.ChangeDue = @order.AmountPaid - @order.TotalCost
          @order.PaidFor = true
          @order.PaidCash = true
        end
      end
    elsif @paid.to_d == @order.TotalCost
      puts "checking equal"
      if @commit.downcase.include?("credit")
        puts "correctpay credit"
        @order.AmountPaid = @paid
        @order.PaidFor = true
        @order.PaidCash = false
      elsif @commit.downcase.include?("cash")
        puts "correctpay cash"
        @order.AmountPaid = @paid
        @order.PaidFor = true
        @order.PaidCash = true
      end
    end
    
    @order.save!
    
    if @order.PaidFor == false
      redirect_to orders_url, :flash => { :notice => "Something went wrong." }
      return
    end
  end
  
  def cancel
    if ( !logged_in? || !current_user.can?("delete", "orders"))
      redirect_to orders_path, :flash => { :notice => "You do not have permission to do this!" }
      return
    end
    
    if !params[:id].present?
      redirect_to orders_path, :flash => { :notice => "No order selected!" }
      return
    end
    
    @order = Order.find(params[:id])
    
    if @order.Cancelled? || @order.Refunded? || @order.PaidFor?
      redirect_to orders_path, :flash => { :notice => "Order not eligible to be cancelled!" }
      return
    end
    
    @order.Cancelled = true;
    @order.save!
    
    redirect_to orders_path, :flash => { :notice => ("Order " + @order.DailyID.to_s + " cancelled!") }
    
  end
  
  
  # PATCH/PUT /orders/1
  # PATCH/PUT /orders/1.json
  def update
    if ( !logged_in? || !current_user.can?("edit", "orders"))
      redirect_to orders_path, :flash => { :danger => "You do not have permission to do this!" }
      return
    end
    
    respond_to do |format|
      if @order.update(order_params)
        format.html { redirect_to @order, notice: 'Order was successfully updated.' }
        format.json { render :show, status: :ok, location: @order }
      else
        format.html { render :edit }
        format.json { render json: @order.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /orders/1
  # DELETE /orders/1.json
  def destroy
    if ( !logged_in? || !current_user.can?("destroy", "orders"))
      redirect_to orders_path, :flash => { :danger => "You do not have permission to do this!" }
      return
    end
    
    @order.destroy
    respond_to do |format|
      format.html { redirect_to orders_url, notice: 'Order was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_order
      @order = Order.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def order_params
      params.fetch()
    end
end
