class OrdersController < ApplicationController
  before_action :set_order, only: [:show, :edit, :update, :destroy]
  
  include OrdersHelper

  # GET /orders
  # GET /orders.json
  def index
    @orders = Order.all
    @products = Product.all
    @customers = Customer.all
    @pending = Order.where("PaidFor IS NULL OR PaidFor=0")
    @completed = Order.where("PaidFor=1")
  end

  # GET /orders/1
  # GET /orders/1.json
  def show
  end

  # GET /orders/startorder
  def startorder
    if params[:custid].present?
      @custid = params[:custid]
      @order = Order.create :PaidFor => false, :user_id => 1, :customer_id => @custid
    else
      @order = Order.create :PaidFor => false, :user_id => 1, :customer_id => 1
    end
    @ordernum = @order.id
    @products = Product.all
    @customers = Customer.all
    @users = User.all
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
  
  #deprecated?
  def pending
    @orders = Order.where('created_at BETWEEN ? AND ?', DateTime.now.beginning_of_day, DateTime.now.end_of_day).all
    @customers = Customer.all
    @products = Product.all
    @options = Option.all
    @orderlines = Orderline.all
  end

  # GET /orders/1/edit
  def edit
  end
  
  def cashout
    
    if !params[:id].present?
      redirect_to orders_url
    end
    
    @id = params[:id]
    
    @order = Order.find(@id)
    
    @customer = Customer.find(@order.customer_id)
    @orderlines = Orderline.where(order_id: @id)
    
    @cashsplit = @order.TotalCost.divmod 1
    @taxes = 0.0
    @centstax = 0.0
    @taxes = (@cashsplit[0] * 0.06)
    
    if((0.10 >= @cashsplit[1]) && (@cashsplit[1] >= 0.00))
      @centstax = 0.0
    elsif((0.24 >= @cashsplit[1]) && (@cashsplit[1] >= 0.11))
      @centstax = 0.01
    elsif((0.41 >= @cashsplit[1]) && (@cashsplit[1] >= 0.25))
      @centstax = 0.02
    elsif((0.58 >= @cashsplit[1]) && (@cashsplit[1] >= 0.42))
      @centstax = 0.03    
    elsif((0.74 >= @cashsplit[1]) && (@cashsplit[1] >= 0.59))
      @centstax = 0.04    
    elsif((0.91 >= @cashsplit[1]) && (@cashsplit[1] >= 0.75))
      @centstax = 0.05
    elsif((0.99 >= @cashsplit[1]) && (@cashsplit[1] >= 0.92))
      @centstax = 0.06      
    end
    
    @taxes = @taxes + @centstax
    
    @order.Tax = @taxes
    @order.save!
      
  end
  
  # POST /orders/getoptions
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
    
    puts @items
    
    @orderlines = Orderline.all
    @products = Product.all
    @options = Option.all
    @categories = Category.all
    
  end
  
  
  # POST /orders/confirmorder
  def confirmorder
  
    @ordernum = params[:ordernum]
    @order = Order.find(@ordernum)
    
    @products = Product.all
    @orderlines = Orderline.all
    @options = Option.all
    @categories = Category.all
    
    @items = @orderlines.where(order_id: @ordernum).ids
    puts @items
    
    @totalcost = 0.0
    
    @items.each do |orderlineid|
      
      thisorderline = @orderlines.find(orderlineid)
      
      if(@categories.find(@products.find(thisorderline.product_id).category_id).Splits == true)
        puts "insplits"
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
      
      @totalcost = @totalcost + thisorderline.ItemTotalCost
    end
    @order.TotalCost = @totalcost
    @order.save!
    
    redirect_to orders_url

  end


  # POST /orders
  # POST /orders.json
  def create
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
