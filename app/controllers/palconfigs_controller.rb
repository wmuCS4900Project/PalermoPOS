class PalconfigsController < ApplicationController
  before_action :set_palconfig, only: [:show, :edit, :update, :destroy]

  # GET /palconfigs
  # GET /palconfigs.json
  def index
    @palconfigs = Palconfig.all
  end

  # GET /palconfigs/1
  # GET /palconfigs/1.json
  def show
  end

  # GET /palconfigs/new
  def new
    @palconfig = Palconfig.new
  end

  # GET /palconfigs/1/edit
  def edit
  end

  # POST /palconfigs
  # POST /palconfigs.json
  def create
    @palconfig = Palconfig.new(palconfig_params)

    respond_to do |format|
      if @palconfig.save
        format.html { redirect_to palconfigs_path, notice: 'Palconfig was successfully created.' }
      else
        format.html { render :new }
        format.json { render json: @palconfig.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /palconfigs/1
  # PATCH/PUT /palconfigs/1.json
  def update
    respond_to do |format|
      if @palconfig.update(palconfig_params)
        format.html { redirect_to palconfigs_path, notice: 'Palconfig was successfully updated.' }
      else
        format.html { render :edit }
        format.json { render json: @palconfig.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /palconfigs/1
  # DELETE /palconfigs/1.json
  def destroy
    @palconfig.destroy
    respond_to do |format|
      format.html { redirect_to palconfigs_url, notice: 'Palconfig was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_palconfig
      @palconfig = Palconfig.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def palconfig_params
      params.require(:palconfig).permit(:name, :val1, :val2, :desc)
    end
end
