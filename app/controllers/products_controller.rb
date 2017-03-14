class ProductsController < ApplicationController
  before_action :set_product, only: [:show, :edit, :update, :destroy]

  # GET /products
  # GET /products.json
  def index
    @products = Product.all
    @categories = Category.all
  end

  # GET /products/1
  # GET /products/1.json
  def show
  end

  # GET /products/new
  def new
    @product = Product.new
    @options = Option.where("category_id = ?", @product.category_id).all
  end

  # GET /products/1/edit
  def edit
    @product = Product.find(params[:id])
    @options = Option.where("category_id = ?", @product.category_id).all
  end

  # POST /products
  # POST /products.json
  def create
    # Check capabilities
    if ( !logged_in? || !current_user.can?("create", "products") )
      redirect_to products_url
      flash[:danger] = "Sorry, you don't have the capability to do that"
      return
    end

    @product = Product.new(product_params)

    respond_to do |format|
      if @product.save
        format.html { redirect_to products_url, notice: 'Product was successfully created.' }
        format.json { render :show, status: :created, location: @product }
      else
        format.html { render :new }
        format.json { render json: @product.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /products/1
  # PATCH/PUT /products/1.json
  def update
    # Check capabilities
    if ( !logged_in? || !current_user.can?("edit", "products") )
      redirect_to products_url
      flash[:danger] = "Sorry, you don't have the capability to do that"
      return
    end

    respond_to do |format|
      puts(product_params)
      if @product.update(product_params)
        format.html { redirect_to products_url, notice: 'Product was successfully updated.' }
        format.json { render :show, status: :ok, location: @product }
      else
        format.html { render :edit }
        format.json { render json: @product.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /products/1
  # DELETE /products/1.json
  def destroy
    # Check capabilities
    if ( !logged_in? || !current_user.can?("edit", "products") )
      redirect_to products_url
      flash[:danger] = "Sorry, you don't have the capability to do that"
      return
    end

    @product.destroy
    respond_to do |format|
      format.html { redirect_to products_url, notice: 'Product was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_product
      @product = Product.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def product_params
      params.require(:product).permit(:Name,:Cost,:category_id,:Abbreviation,:freeoptions => [])
    end
end
