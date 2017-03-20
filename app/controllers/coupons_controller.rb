class CouponsController < ApplicationController
  before_action :set_coupon, only: [:show, :edit, :update, :destroy]

  # GET /coupons
  # GET /coupons.json
  def index
    if ( !logged_in? || !current_user.can?("view", "coupons"))
      redirect_to root_path, :flash => { :notice => "You do not have permission to do this!" }
      return
    end
    
    @coupons = Coupon.all
  end

  # GET /coupons/1
  # GET /coupons/1.json
  def show
    if ( !logged_in? || !current_user.can?("view", "coupons"))
      redirect_to root_path, :flash => { :notice => "You do not have permission to do this!" }
      return
    end
  end

  # GET /coupons/new
  def new
    if ( !logged_in? || !current_user.can?("create", "coupons"))
      redirect_to root_path, :flash => { :notice => "You do not have permission to do this!" }
      return
    end
    @coupon = Coupon.new
  end

  # GET /coupons/1/edit
  def edit
    if ( !logged_in? || !current_user.can?("edit", "coupons"))
      redirect_to root_path, :flash => { :notice => "You do not have permission to do this!" }
      return
    end
  end
  
  def save
    if ( !logged_in? || !current_user.can?("create", "coupons"))
      redirect_to root_path, :flash => { :notice => "You do not have permission to do this!" }
      return
    end
    
    if params[:id].present? && !params[:id].nil?
      @coupon = Coupon.find(params[:id])
    else
      @coupon = Coupon.new
    end
    
    @coupon.Name = params[:Name]
    if params[:Type] == 'dollarsoff'
      @coupon.Type = :dollars
    else
      @coupon.Type = :percent
    end
    @coupon.DollarsOff = params[:DollarsOff]
    @coupon.PercentOff = params[:PercentOff]
    @coupon.ProductData = params[:ProductData]
    @coupon.ProductType = params[:ProductType]
    @coupon.ProductMinOptions = params[:ProductMinOptions]
    @coupon.save!
    redirect_to coupons_path, notice: 'Coupon was successfully saved.'
    
  end

  # POST /coupons
  # POST /coupons.json
  # DEPRECATED
  def create
    @coupon = Coupon.new(coupon_params)

    @products = []
    if params[:product1].present?
      @products.push(params[:product1]['id'])
    end
    if params[:product2].present?
      @products.push(params[:product2]['id'])
    end
    if params[:product3].present?
      @products.push(params[:product3]['id'])
    end
    if params[:product4].present?
      @products.push(params[:product4]['id'])
    end
    @coupon.Requirements = @products
    
    @categories = []
    if params[:cat1].present?
      @categories.push(params[:cat1]['id'])
    end
    if params[:cat2].present?
      @categories.push(params[:cat2]['id'])
    end
    @coupon.Requirements2 = @categories

    respond_to do |format|
      if @coupon.save
        format.html { redirect_to @coupon, notice: 'Coupon was successfully created.' }
        format.json { render :show, status: :created, location: @coupon }
      else
        format.html { render :new }
        format.json { render json: @coupon.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /coupons/1
  # PATCH/PUT /coupons/1.json
  # DEPRECATED
  def update
    
    puts params
    
    @products = []
    if params[:product1].present?
      @products.push(params[:product1]['id'])
    end
    if params[:product2].present?
      @products.push(params[:product2]['id'])
    end
    if params[:product3].present?
      @products.push(params[:product3]['id'])
    end
    if params[:product4].present?
      @products.push(params[:product4]['id'])
    end
    @coupon.Requirements = @products
    
    @categories = []
    if params[:cat1].present?
      @categories.push(params[:cat1]['id'])
    end
    if params[:cat2].present?
      @categories.push(params[:cat2]['id'])
    end
    @coupon.Requirements2 = @categories
    
    respond_to do |format|
      if @coupon.update(coupon_params)
        format.html { redirect_to @coupon, notice: 'Coupon was successfully updated.' }
        format.json { render :show, status: :ok, location: @coupon }
      else
        format.html { render :edit }
        format.json { render json: @coupon.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /coupons/1
  # DELETE /coupons/1.json
  def destroy
    if ( !logged_in? || !current_user.can?("destroy", "coupons"))
      redirect_to root_path, :flash => { :notice => "You do not have permission to do this!" }
      return
    end
    
    @coupon.destroy
    respond_to do |format|
      format.html { redirect_to coupons_url, notice: 'Coupon was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_coupon
      @coupon = Coupon.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def coupon_params
      params.require(:coupon).permit(:Name, :Type, :DollarsOff, :PercentOff, :ProductData, :ProductType, :ProductMinOptions, :ProductMinPrice)
    end
end
