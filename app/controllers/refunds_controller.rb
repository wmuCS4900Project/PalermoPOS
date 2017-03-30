class RefundsController < ApplicationController
  before_action :set_refund, only: [:show, :edit, :update, :destroy]

  # GET /refunds
  # GET /refunds.json
  def index
    if ( !logged_in? || !current_user.can?("view", "orders"))
      redirect_to root_path, :flash => { :notice => "You do not have permission to do this!" }
      return
    end

    @refunds = Refund.all

    if params[:order_id]
      @order = Order.find(params[:order_id].to_i)
    end
  end

  # GET /refunds/1
  # GET /refunds/1.json
  def show
    if ( !logged_in? || !current_user.can?("edit", "orders"))
      redirect_to root_path, :flash => { :notice => "You do not have permission to do this!" }
      return
    end
  end

  # GET /refunds/new
  def new
    if ( !logged_in? || !current_user.can?("edit", "orders"))
      redirect_to root_path, :flash => { :notice => "You do not have permission to do this!" }
      return
    end

    @refund = Refund.new
    @completed = Order.where("PaidFor IS true").all

    if params[:order_id]
      begin 
        @order = Order.find(params[:order_id].to_i)
      rescue ActiveRecord::RecordNotFound => e
        @order = nil
      end

      if !@completed.include?(@order)
        # Whoa, this is not a completed order
        flash[:danger] = "Sorry, this is not a completed order"
        redirect_to orders_path
        return
      end 
      @orderlines = Orderline.where("order_id = ?", @order.id).all
    end
  end

  # GET /refunds/1/edit
  def edit
    if ( !logged_in? || !current_user.can?("edit", "orders"))
      redirect_to root_path, :flash => { :notice => "You do not have permission to do this!" }
      return
    end

    @refund = Refund.new

    if params[:order_id]
      begin 
        @order = Order.find(params[:order_id].to_i)
      rescue ActiveRecord::RecordNotFound => e
        @order = nil
      end
      
      @completed = Order.where("PaidFor IS true").all

      if !@completed.include?(@order)
        # Whoa, this is not a completed order
        flash[:danger] = "Sorry, this is not a completed order"
        redirect_to orders_path
        return
      end

      @orderlines = Orderline.where("order_id = ?", @order.id).all
    end
  end

  # POST /refunds
  # POST /refunds.json
  def create
    if ( !logged_in? || !current_user.can?("edit", "orders"))
      redirect_to root_path, :flash => { :notice => "You do not have permission to do this!" }
      return
    end

    @completed = Order.where("PaidFor IS true").all
    order = params[:order_id]

    if !@completed.include?(@order)
      # Whoa, this is not a completed order
      flash[:danger] = "Sorry, this is not a completed order"
      redirect_to orders_path
      return
    end

    @refund = Refund.new({:order_id => params[:order_id], :total => refund_params[:total], :subtotal => refund_params[:subtotal]})

    respond_to do |format|
      if @refund.save
        format.html { redirect_to @refund, notice: 'Refund was successfully created.' }
        format.json { render :show, status: :created, location: @refund }
      else
        format.html { render :new }
        format.json { render json: @refund.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /refunds/1
  # PATCH/PUT /refunds/1.json
  def update
    if ( !logged_in? || !current_user.can?("edit", "orders"))
      redirect_to root_path, :flash => { :notice => "You do not have permission to do this!" }
      return
    end

    @completed = Order.where("PaidFor IS true").all
    order = params[:order_id]

    if !@completed.include?(@order)
      # Whoa, this is not a completed order
      flash[:danger] = "Sorry, this is not a completed order"
      redirect_to orders_path
      return
    end
    respond_to do |format|
      if @refund.update(refund_params)
        format.html { redirect_to @refund, notice: 'Refund was successfully updated.' }
        format.json { render :show, status: :ok, location: @refund }
      else
        format.html { render :edit }
        format.json { render json: @refund.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /refunds/1
  # DELETE /refunds/1.json
  def destroy
    @refund.destroy
    respond_to do |format|
      format.html { redirect_to refunds_url, notice: 'Refund was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_refund
      @refund = Refund.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def refund_params
      params.fetch(:refund, {})
    end
end
