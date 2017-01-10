class OrdersController < ApplicationController
  before_action :set_order, only: [:show, :edit, :update, :destroy]
  
  include OrdersHelper

  # GET /orders
  # GET /orders.json
  def index
    @orders = Order.all
    @products = Product.all
    @pending = Order.where("PaidFor IS NULL OR PaidFor=0")
    @completed = Order.where("PaidFor=1")
  end

  # GET /orders/1
  # GET /orders/1.json
  def show
  end

  # GET /orders/start
  def startorder
    if params[:custid].present?
      @custid = params[:custid]
      @order = Order.create :PaidFor => false, :user_id => 1, :customer_id => @custid
      puts "did order good"
    else
      @order = Order.create :PaidFor => false, :user_id => 1, :customer_id => 1
      puts "did order default"
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
      
    end

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
