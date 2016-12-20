class OrdersController < ApplicationController
  before_action :set_order, only: [:show, :edit, :update, :destroy]

  # GET /orders
  # GET /orders.json
  def index
    @orders = Order.all
    @products = Product.all
  end

  # GET /orders/1
  # GET /orders/1.json
  def show
  end

  # GET /orders/new
  def new
    @order = Order.create :PaidFor => false, :user_id => 1, :customer_id => 1
    @ordernum = @order.id
    @products = Product.all
    @customers = Customer.all
    @users = User.all
  end

  # GET /orders/1/edit
  def edit
  end
  
  def pickoptions
    @order = Order.find(params[:ordernum])
    @ordernum = params[:ordernum]

    user = params[:user]
    @order.user_id = user
    
    cust = params[:customer]
    @order.customer_id = cust
    
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
  
  def confirmorder
  
    @ordernum = params[:ordernum]
    @order = Order.find(@ordernum)
    
    @products = Product.all
    @orderlines = Orderline.all
    @options = Option.all
    @categories = Category.all
    
    @i = params[:items]
    @items = @i.split(" ")
    
    @items.each do |orderlineid|
      
      thisorderline = @orderlines.find(orderlineid)
      cost = @products.find(thisorderline.product_id).Cost
      
      if(@categories.find(@products.find(thisorderline.product_id).category_id).Splits == true)
        
        
      else  
        opname = orderlineid + "options"
        thisoptions = params["#{opname}"]
        puts "this is " + thisoptions.to_s
        thisoptions.each do |c|
          cost = cost + @options.find(c).Cost
        end
        thisorderline.Options1 = thisoptions

      end
      
      thisorderline.ItemTotalCost = cost
      thisorderline.save!
    end

  end

  
  
  def confirmorder2 #I AM DEPRECATED
    
    @ordernum = params[:ordernum]
    @order = Order.find(@ordernum)
    @products = Product.all
    @orderlines = Orderline.all
    @items = params[:items]
    
    @items.each do |a|
      a.save!
    end
    
    @itemnums = @orderlines.where(order_id: @ordernum).ids
    @options = Option.all
    @categories = Category.all
    
    @itemnums.each do |a|
      @orderline = @orderlines.find(a)
      
      cost = @products.find(@orderline.product_id).Cost
      
      if @categories.find(@products.find(@orderline.product_id).category_id).Splits
        
        @pname1 = ":" + @orderline.id.to_s + "options1"
        Rails.logger.debug("pname1: #{@pname1.inspect}")
        if params.has_key?(@pname1.to_s)
          @ops1 = params[@pname1.to_s]
          Rails.logger.debug("Ops1: #{@ops1.inspect}")
          @ops1.each do |b|
            cost = cost + (@options.find(b).Cost * 0.5)
          end
          @orderline.Options1 = @ops1
        else
          Rails.logger.debug("key not found")
        end
        
        @pname2 = ":" + @orderline.id.to_s + "options2"
        Rails.logger.debug("pname2: #{@pname2.inspect}")
        if params.has_key?(@pname2.to_s)
          @ops2 = params[@pname2.to_s]
          Rails.logger.debug("Ops2: #{@ops2.inspect}")
          @ops2.each do |b|
            cost = cost + (@options.find(b).Cost * 0.5)
          end
          @orderline.Options2 = @ops2
        else
          Rails.logger.debug("key not found")
        end
        
      else
        
        pname = ":" + @orderline.id.to_s + "options"
        if params.has_key?(pname)
          @ops = params[pname]

          @ops.each do |b|
           cost = cost + @options.find(b).Cost
          end
          @orderline.Options1 = @ops
        end
        
        
      end
      
      @orderline.ItemTotalCost = cost
      
      @orderline.save!
        
    end
    
    puts params.inspect    
    
    
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
