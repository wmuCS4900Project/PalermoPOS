class CategoriesController < ApplicationController
  before_action :set_category, only: [:show, :edit, :update, :destroy]

  # GET /categories
  # GET /categories.json
  def index
    @categories = Category.all
  end

  # GET /categories/1
  # GET /categories/1.json
  def show
    # Check capabilities
    if ( !logged_in? || !current_user.can?("view", "categories") )
      redirect_to categories_url
      flash[:danger] = "Sorry, you don't have the capability to do that"
    end
  end

  # GET /categories/new
  def new
    # Check capabilities
    if ( !logged_in? || !current_user.can?("create", "categories") )
      redirect_to categories_url
      flash[:danger] = "Sorry, you don't have the capability to do that"
    end
    
    @category = Category.new
  end

  # GET /categories/1/edit
  def edit
    # Check capabilities
    if ( !logged_in? || !current_user.can?("edit", "categories") )
      redirect_to categories_url
      flash[:danger] = "Sorry, you don't have the capability to do that"
    end
  end

  # POST /categories
  # POST /categories.json
  def create
    # Check capabilities
    if ( !logged_in? || !current_user.can?("create", "categories") )
      redirect_to categories_url
      flash[:danger] = "Sorry, you don't have the capability to do that"
      return
    end

    @category = Category.new(category_params)

    respond_to do |format|
      if @category.save
        format.html { redirect_to @category, notice: 'Category was successfully created.' }
        format.json { render :show, status: :created, location: @category }
      else
        format.html { render :new }
        format.json { render json: @category.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /categories/1
  # PATCH/PUT /categories/1.json
  def update
    # Check capabilities
    if ( !logged_in? || !current_user.can?("edit", "categories") )
      redirect_to categories_url
      flash[:danger] = "Sorry, you don't have the capability to do that"
      return
    end

    respond_to do |format|
      if @category.update(category_params)
        format.html { redirect_to @category, notice: 'Category was successfully updated.' }
        format.json { render :show, status: :ok, location: @category }
      else
        format.html { render :edit }
        format.json { render json: @category.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /categories/1
  # DELETE /categories/1.json
  def destroy
    # Check capabilities
    if ( !logged_in? || !current_user.can?("destroy", "categories") )
      redirect_to categories_url
      flash[:danger] = "Sorry, you don't have the capability to do that"
      return
    end

    @category.destroy
    respond_to do |format|
      format.html { redirect_to categories_url, notice: 'Category was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_category
      @category = Category.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def category_params
      params.fetch(:category, {})
    end
end
