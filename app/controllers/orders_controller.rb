class OrdersController < ApplicationController
  before_action :set_order, only: [:show, :edit, :update, :destroy]
  
  include OrdersHelper

  # GET /orders
  # GET /orders.json
  def index
    @customers = Customer.all
    @pending = Order.where("PaidFor IS false AND Cancelled IS false AND Refunded IS false AND created_at BETWEEN ? AND ?", DateTime.now.beginning_of_day, DateTime.now.end_of_day).all
    @cancelled = Order.where("Cancelled IS true AND created_at BETWEEN ? AND ?", DateTime.now.beginning_of_day, DateTime.now.end_of_day).all
    @completed = Order.where("PaidFor IS true AND created_at BETWEEN ? AND ?", DateTime.now.beginning_of_day, DateTime.now.end_of_day).all
    @refunded = Order.where("Refunded IS true AND created_at BETWEEN ? AND ?", DateTime.now.beginning_of_day, DateTime.now.end_of_day).all
  end
  
  def pickup
    @customers = Customer.all
    @orders = Order.where("PaidFor IS false AND Cancelled IS false AND Refunded IS false AND IsDelivery IS false AND created_at BETWEEN ? AND ?", DateTime.now.beginning_of_day, DateTime.now.end_of_day).all
  end
  
  def delivery
    @customers = Customer.all
    @orders = Order.where("PaidFor IS false AND Cancelled IS false AND Refunded IS false AND IsDelivery IS true AND created_at BETWEEN ? AND ?", DateTime.now.beginning_of_day, DateTime.now.end_of_day).all
  end
  
  def oldorders
    @customers = Customer.all
    @pending = Order.where("PaidFor IS false AND Cancelled IS false AND Refunded IS false AND created_at < ?", DateTime.now.beginning_of_day).all
    @cancelled = Order.where("Cancelled IS true AND created_at < ?", DateTime.now.beginning_of_day).all
    @completed = Order.where("PaidFor IS true AND created_at < ?", DateTime.now.beginning_of_day).all
    @refunded = Order.where("Refunded IS true AND created_at < ?", DateTime.now.beginning_of_day).all
  end
  
  def selectproduct
    if !params[:order_id].present?
      redirect_to orders_path, :flash => { :notice => "No current order!" }
      return
    end
    @order = Order.find(params[:order_id])
    @categories = Category.all
  end
  
  #creates a new product when selected on the orders page
  def addproducttoorder
    if !params[:order_id].present?
      redirect_to orders_path, :flash => { :notice => "No current order!" }
      return
    elsif !params[:product_id].present?
      redirect_to orders_path, :flash => { :notice => "No product selected!" }
      return
    end
      
    puts "THIS IS A THING"
    puts params.inspect
    
    @order = Order.find(params[:order_id])
    @product = Product.find(params[:product_id])
    @orderline = Orderline.create :product_id => @product.id, :order_id => @order.id
    redirect_to orders_chooseoptions_path(order_id: @order.id, orderline_id: @orderline.id)
  end
  
  def commitorder
    if !params[:order_id].present?
      redirect_to orders_path, :flash => { :notice => "No current order!" }
    end 
    
    @orderid = params[:order_id]
    @pickup = params[:pickupordeliveryouter]
    @discount = params[:discount]
    @user = params[:user_id]
    @driver = params[:driver_id]
    @comments = params[:comments]

    orders_options_update(@orderid, @pickup, @discount, @user, @driver, @comments)

    redirect_to orders_path, :flash => { :notice => "Order saved!" }
  end
  
  #view handles selection of options for an orderline
  def chooseoptions
    if !params[:order_id].present?
      redirect_to orders_path, :flash => { :notice => "No current order!" }
    elsif !params[:orderline_id].present?
      redirect_to orders_path, :flash => { :notice => "No line selected!" }
    end
    
    @order = Order.find(params[:order_id])
    @orderline = Orderline.find(params[:orderline_id])
    @product = Product.find(@orderline.product_id)
    @options = Option.where("category_id = ?", @product.category_id).all
    @ops1 = "options1[]"
    @ops2 = "options2[]"
    @ops3 = "options3[]"
    @ops4 = "options4[]"
  end
  
  #saves 
  def addoptions
    
    if !params[:order_id].present?
      redirect_to orders_path, :flash => { :notice => "No current order!" }
    elsif !params[:orderline_id].present?
      redirect_to orders_path, :flash => { :notice => "No line selected!" }
    end

    @order = Order.find(params[:order_id])
    @orderline = Orderline.find(params[:orderline_id])
    
    puts "THIS IS A THING"
    puts params.inspect
    
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
    
    @orderlines = Orderline.where("order_id = ?",@order.id).all
    
    @subtotal = 0.0
    @orderlines.each do |a|
       @subtotal += a.ItemTotalCost
    end

    @order.Subtotal = @subtotal
    @order.save!
      
    calc_taxes(@order.id)
    redirect_to orders_selectproduct_path(order_id: @order.id), :flash => { :notice => "Item saved!" }
  end
  
  def all
    @customers = Customer.all
    @pending = Order.where("PaidFor IS false AND Cancelled IS false AND Refunded IS false")
    @cancelled = Order.where("Cancelled IS true")
    @completed = Order.where("PaidFor IS true")
    @refunded = Order.where("Refunded IS true")
  end

  # GET /orders/1
  # GET /orders/1.json
  def show
    @order = Order.find(params[:id])
    @customers = Customer.all
    @orderlines = Orderline.where("order_id = ?",@order.id).all
    @products = Product.all
    @options = Option.all
  end

  
  # GET /orders/custsearch
  def custsearch
    c = params[:criteria]
    crit = params[:searchcriteria]
    if crit == "phone"
      @results = Customer.where("Phone like ?", "%#{c}%")
    elsif crit == "name"
      r1 = Customer.where("FirstName like ?", "%#{c}%")
      r2 = Customer.where("LastName like ?", "%#{c}%")
      @results = r1 + r2
    elsif crit == "address"
      r1 = Customer.where("AddressNumber like ?", "%#{c}%")
      r2 = Customer.where("StreetName like ?", "%#{c}%")
      @results = r1 + r2
    elsif crit == "city"
      @results = Customer.where("City like ?", "%#{c}%")
    elsif crit == "zip"
      @results = Customer.where("Zip like ?", "%#{c}%")
    end
  end
  
  #get receipt
  def receipt
    @order_id = params[:order_id]
    @order = Order.find(@order_id)
    @customer = Customer.find(@order.customer_id)
    @options = Option.all
    @products = Product.all
  end
  

  # GET /orders/1/edit
  def edit
  end
  
  
  # GET /orders/startorder
  def startorder
    if params[:custid].present?
      @order = Order.create :PaidFor => false, :user_id => 1, :customer_id => params[:custid]
      puts @order.inspect
      redirect_to orders_selectproduct_path(order_id: @order.id)
      return
    else
      redirect_to orders_path, :flash => { :notice => "No customer selected!" }    
      return
    end
  end
  
  # deprecated
  # POST /orders/pickoptions
  def pickoptions
    @order = Order.find(params[:ordernum])
    @ordernum = params[:ordernum]

    user = params[:user]
    @order.user_id = user
    
    @order.save!
    
    is = params[:items]
    @itemlist = []
    is.each do |b|
      if b != "1"
        @itemlist.push(b)
      end
    end
    
    @items = []
    
    @itemlist.each do |a|
      @newol = Orderline.create :product_id => a, :order_id => @order.id
      @items.push(@newol.id)
    end
    
    @orderlines = Orderline.all
    @products = Product.all
    @options = Option.all
    @categories = Category.all
    
  end
  
  # deprecated
  # POST /orders/confirmorder
  def confirmorder
  
    @ordernum = params[:ordernum]
    @order = Order.find(@ordernum)
    
    @products = Product.all
    @options = Option.all
    @categories = Category.all
    
    @customers = Customer.all
    @orderlines = Orderline.where("order_id = ?",@order.id).all
    
    @items = @orderlines.where(order_id: @ordernum).ids

    @subtotal = 0.0
    
    @items.each do |orderlineid|
      thisorderline = @orderlines.find(orderlineid)
      if(@categories.find(@products.find(thisorderline.product_id).category_id).Splits == true)
        thisorderline.splitstyle = params["#{orderlineid.to_s + "split"}"]
        if(thisorderline.whole?)
          line_saver(thisorderline, params[orderlineid.to_s + "options1"], nil, nil, nil)
        elsif(thisorderline.halves?)
          line_saver(thisorderline, params[orderlineid.to_s + "options1"], params[orderlineid.to_s + "options2"], nil, nil)
        elsif(thisorderline.quarters?)
          line_saver(thisorderline, params[orderlineid.to_s + "options1"], params[orderlineid.to_s + "options2"], params[orderlineid.to_s + "options3"], params[orderlineid.to_s + "options4"])
        end
      else  
        thisorderline.splitstyle = :whole
        line_saver(thisorderline, params[orderlineid.to_s + "options"], nil, nil, nil)
      end
      @subtotal = @subtotal + thisorderline.ItemTotalCost
    end
    
    @order.Subtotal = @subtotal
    
    @order.save!
    
    calc_taxes(@order.id)

    redirect_to orders_receipt_url(id: @order.id)
    
  end
  
  def receipt
    @order = Order.find(params[:id])
    @products = Product.all
    @options = Option.all
    @categories = Category.all
    
    if params[:print].present?
      @print = false
    else
      @print = true
    end
    
    @customers = Customer.all
    @orderlines = Orderline.where("order_id = ?",@order.id).all
  end

  def cashout
    
    if !params[:id].present?
      redirect_to orders_url
      return
    end

    @id = params[:id]
    
    @order = Order.find(@id)
    @products = Product.all

    if params[:discount].present?
      @order.Discounts = params[:discount]
    end
    
    @order.save!
    
    @customer = Customer.find(@order.customer_id)
    @orderlines = Orderline.where(order_id: @id)
    
    calc_taxes(@order.id)
    
    @order = Order.find(@id)
      
  end
  
  def cashedout
    
    if !params[:id].present?
      redirect_to orders_url
      return
    end
    
    @id = params[:id]
    
    @order = Order.find(@id)
    @customer = Customer.find(@order.customer_id)
    @orderlines = Orderline.where(order_id: @id)
    @products = Product.all


    if params[:amountpaid].present?
      @paid = params[:amountpaid]
    else
      @paid = @order.TotalCost
    end
    
    @order.AmountPaid = @paid
    
    if(@order.AmountPaid > @order.TotalCost.to_f)
      @order.ChangeDue = @order.AmountPaid - @order.TotalCost.to_f
    end
    
    @order.PaidCash = params[:cashorcredit]
    @order.PaidFor = true
    @order.save!
    
  end
  
  def endofday
    @customers = Customer.all
    @pending = Order.where("PaidFor IS false AND Cancelled IS false AND Refunded IS false AND created_at BETWEEN ? AND ?", DateTime.now.beginning_of_day, DateTime.now.end_of_day).all
    @cancelled = Order.where("Cancelled IS true AND created_at BETWEEN ? AND ?", DateTime.now.beginning_of_day, DateTime.now.end_of_day).all
    @completed = Order.where("PaidFor IS true AND created_at BETWEEN ? AND ?", DateTime.now.beginning_of_day, DateTime.now.end_of_day).all
    @refunded = Order.where("Refunded IS true AND created_at BETWEEN ? AND ?", DateTime.now.beginning_of_day, DateTime.now.end_of_day).all
    
    @subtotals = Array.new(4, 0.0)
    @taxtotals = Array.new(4, 0.0)
    @tottotals = Array.new(4, 0.0)
    @cashtotal = Array.new(4, 0.0)
    @credittotal = Array.new(4, 0.0)
    
    @pending.each do |a|
      @subtotals[0] += a.Subtotal
      @taxtotals[0] += a.Tax
      @tottotals[0] += a.TotalCost
      if a.PaidCash == true
        @cashtotal[0] += a.TotalCost
      else
        @credittotal[0] += a.TotalCost
      end
    end
    
    @completed.each do |a|
      @subtotals[1] += a.Subtotal
      @taxtotals[1] += a.Tax
      @tottotals[1] += a.TotalCost
      if a.PaidCash == true
        @cashtotal[1] += a.TotalCost
      else
        @credittotal[1] += a.TotalCost
      end
    end
    
    @cancelled.each do |a|
      @subtotals[2] += a.Subtotal
      @taxtotals[2] += a.Tax
      @tottotals[2] += a.TotalCost
      if a.PaidCash == true
        @cashtotal[2] += a.TotalCost
      else
        @credittotal[2] += a.TotalCost
      end
    end

    @completed.each do |a|
      @subtotals[3] += a.Subtotal
      @taxtotals[3] += a.Tax
      @tottotals[3] += a.TotalCost
      if a.PaidCash == true
        @cashtotal[3] += a.TotalCost
      else
        @credittotal[3] += a.TotalCost
      end
    end
    

    
  end
  

  # PATCH/PUT /orders/1
  # PATCH/PUT /orders/1.json
  def update
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
