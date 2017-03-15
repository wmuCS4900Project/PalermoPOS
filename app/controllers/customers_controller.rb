class CustomersController < ApplicationController
  before_action :set_customer, only: [:show, :edit, :update, :destroy]

  # GET /customers
  # GET /customers.json
  def index
    @customers = Customer.limit(100)
  end

  # GET /customers/1
  # GET /customers/1.json
  def show
  end

  # GET /customers/new
  def new
    @customer = Customer.new
  end

  # GET /customers/1/edit
  def edit
  end

  # POST /customers
  # POST /customers.json
  def create
    # Check capabilities
    if ( !logged_in? || !current_user.can?("create", "customers") )
      redirect_to customers_url
      flash[:danger] = "Sorry, you don't have the capability to do that"
    end

    @customer = Customer.new(customer_params)

    respond_to do |format|
      if @customer.save
        format.html { redirect_to @customer, notice: 'Customer was successfully created.' }
        format.json { render :show, status: :created, location: @customer }
      else
        format.html { render :new }
        format.json { render json: @customer.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /customers/1
  # PATCH/PUT /customers/1.json
  def update
    # Check capabilities
    if ( !logged_in? || !current_user.can?("edit", "customers") )
      redirect_to customers_url
      flash[:danger] = "Sorry, you don't have the capability to do that"
    end

    respond_to do |format|
      if @customer.update(customer_params)
        format.html { redirect_to @customer, notice: 'Customer was successfully updated.' }
        format.json { render :show, status: :ok, location: @customer }
      else
        format.html { render :edit }
        format.json { render json: @customer.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /customers/1
  # DELETE /customers/1.json
  def destroy
    # Check capabilities
    if ( !logged_in? || !current_user.can?("destroy", "customers") )
      redirect_to customers_url
      flash[:danger] = "Sorry, you don't have the capability to do that"
    end

    @customer.destroy
    respond_to do |format|
      format.html { redirect_to customers_url, notice: 'Customer was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_customer
      @customer = Customer.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def customer_params
      params.require(:customer).permit(:Phone, :LastName, :FirstName, :AddressNumber, :StreetName, :City, :State, :Zip, :Directions, :LastOrderNumber, :FirstOrderDate, :TotalOrderCount, :TotalOrderDollars, :BadCkCount, :BadCkTotal, :LongDelivery, :LastOrderDate, :Notes)
    end
end
