class CapsController < ApplicationController
  before_action :set_cap, only: [:show, :edit, :update, :destroy]

  # GET /caps
  # GET /caps.json
  def index
    if ( !logged_in? || !current_user.can?("view", "capabilities") )
      redirect_to caps_url
      flash[:danger] = "Sorry, you don't have the capability to do that"
      return
    end
    
    @caps = Cap.all
    @roles = Role.all
  end

  # GET /caps/1
  # GET /caps/1.json
  def show
    if ( !logged_in? || !current_user.can?("view", "capabilities") )
      redirect_to caps_url
      flash[:danger] = "Sorry, you don't have the capability to do that"
      return
    end
    
    @roles = Role.all
  end

  # GET /caps/new
  def new
    if ( !logged_in? || !current_user.can?("create", "capabilities") )
      redirect_to caps_url
      flash[:danger] = "Sorry, you don't have the capability to do that"
      return
    end
    
    @cap = Cap.new
    @roles = Role.all
  end

  # GET /caps/1/edit
  def edit
    if ( !logged_in? || !current_user.can?("edit", "capabilities") )
      redirect_to caps_url
      flash[:danger] = "Sorry, you don't have the capability to do that"
      return
    end
    
    @roles = Role.all
  end

  # POST /caps
  # POST /caps.json
  def create
    # Check capabilities
    if ( !logged_in? || !current_user.can?("create", "capabilities") )
      redirect_to caps_url
      flash[:danger] = "Sorry, you don't have the capability to do that"
      return
    end

    @cap = Cap.new(:role_id => params[:role_id], :action => params[:ability], :object => params[:object])

    respond_to do |format|
      if @cap.save
        format.html { redirect_to @cap, notice: 'Capability was successfully created.' }
        format.json { render :show, status: :created, location: @cap }
      else
        format.html { render :new }
        format.json { render json: @cap.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /caps/1
  # PATCH/PUT /caps/1.json
  def update
    # Check capabilities
    if ( !logged_in? || !current_user.can?("edit", "capabilities") )
      redirect_to caps_url
      flash[:danger] = "Sorry, you don't have the capability to do that"
      return
    end

    respond_to do |format|
      if @cap.update(:role_id => params[:role_id], :action => params[:ability], :object => params[:object])
        format.html { redirect_to @cap, notice: 'Capability was successfully updated.' }
        format.json { render :show, status: :ok, location: @cap }
      else
        format.html { render :edit }
        format.json { render json: @cap.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /caps/1
  # DELETE /caps/1.json
  def destroy
    # Check capabilities
    if ( !logged_in? || !current_user.can?("destroy", "capabilities") )
      redirect_to caps_url
      flash[:danger] = "Sorry, you don't have the capability to do that"
      return
    end

    @cap.destroy
    respond_to do |format|
      format.html { redirect_to caps_url, notice: 'Capability was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_cap
      @cap = Cap.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def cap_params
      params.fetch(:cap, {})
    end
end
