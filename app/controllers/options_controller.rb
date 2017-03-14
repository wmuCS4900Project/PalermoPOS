class OptionsController < ApplicationController
  before_action :set_option, only: [:show, :edit, :update, :destroy]

  # GET /options
  # GET /options.json
  def index
    if params[:category_id].present?
      @category_id = params[:category_id]
      @options = Option.where('category_id = ?', @category_id).all
    else
      @options = Option.all
    end
    @categories = Category.all
  end

  # GET /options/1
  # GET /options/1.json
  def show
  end

  # GET /options/new
  def new
    @option = Option.new
  end

  # GET /options/1/edit
  def edit
  end
  
  def changeall
    @options = Option.all
  end
  
  def changeallapply
    if !params[:changeto].present?
      redirect_to options_changeall_path, :flash => { :notice => "No value included!" }
      return
    end
    
    if !params[:ids].present?
      redirect_to options_changeall_path, :flash => { :notice => "No items selected!" }
      return
    end
    
    @field = params[:field]
    @changeto = params[:changeto]
    
    @optionsSelected = Option.where(id: params[:ids])
    puts @optionsSelected
    
    @optionsSelected.each do |this|
      if @field == "Name"
        this.Name = @changeto
      elsif @field == "Cost"
        this.Cost = @changeto
      elsif @field == "category_id"
        this.category_id = @changeto
      elsif @field == "Abbreviation"
        this.Abbreviation = @changeto
      end
      this.save!
    end
    
    redirect_to options_path, :flash => { :notice => "Multiple options updated!" }
    
  end

  # POST /options
  # POST /options.json
  def create
    # Check capabilities
    if ( !logged_in? || !current_user.can?("create", "options") )
      redirect_to options_url
      flash[:danger] = "Sorry, you don't have the capability to do that"
    end

    @option = Option.new(option_params)

    respond_to do |format|
      if @option.save
        format.html { redirect_to @option, notice: 'Option was successfully created.' }
        format.json { render :show, status: :created, location: @option }
      else
        format.html { render :new }
        format.json { render json: @option.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /options/1
  # PATCH/PUT /options/1.json
  def update
    # Check capabilities
    if ( !logged_in? || !current_user.can?("edit", "options") )
      redirect_to options_url
      flash[:danger] = "Sorry, you don't have the capability to do that"
    end

    respond_to do |format|
      if @option.update(option_params)
        format.html { redirect_to options_url, notice: 'Option was successfully updated.' }
        format.json { render :show, status: :ok, location: @option }
      else
        format.html { render :edit }
        format.json { render json: @option.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /options/1
  # DELETE /options/1.json
  def destroy
    # Check capabilities
    if ( !logged_in? || !current_user.can?("destroy", "options") )
      redirect_to
      flash[:danger] = "Sorry, you don't have the capability to do that"
    end

    @option.destroy
    respond_to do |format|
      format.html { redirect_to options_url, notice: 'Option was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_option
      @option = Option.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def option_params
      params.require(:option).permit(:Name,:Cost,:category_id,:Abbreviation,:ChildOf)
    end
end
