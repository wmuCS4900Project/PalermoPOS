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

    user = params[:user]
    @order.user_id = user
    
    cust = params[:customer]
    @order.customer_id = cust
    
    @order.save!
    
    items = params[:items]
    @itemlist = []
    items.each do |b|
      if b != "1"
        @itemlist.push(b)
      end
    end
    
    @itemnums = []
    
    @itemlist.each do |a|
      @i = Orderline.create :product_id => a, :order_id => @order.id
      @itemnums.push(@i.id)
    end
    
    @products = Product.all
    @options = Option.all
    @categories = Category.all
  end
  
  def confirmorder
    
    
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
