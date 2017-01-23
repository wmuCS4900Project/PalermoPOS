class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy]

  # GET /users
  # GET /users.json
  def index
    @users = User.all
  end

  # GET /users/1
  # GET /users/1.json
  def show
  end


  # GET /users/new
  def new
    @user = User.new
    @roles = {:admin => "Administrator", :driver => "Driver"}
  end

  # GET /users/1/edit
  def edit
    @roles = {:admin => "Administrator", :driver => "Driver"}
  end

  # POST /users
  # POST /users.json
  def create
    puts params[:user]
    # Get roles from params 
    args = { :Name => params[:user][:Name] , :username => params[:user][:username], :password => params[:user][:password] }
    puts args
    @user = User.new( args )
    roles = params["roles"]
    puts "--------------------"
    puts roles
      if @user.save
        # Add Roles
        roles.each do |role|
          puts role
          @user.add_role(role)
        end

        flash[:success] = "User successfully added"
        redirect_to @user
      else
        flash[:danger] = "Error: Could not add user" # TODO: More meaningful message
        redirect_to '/users'
      end
  end

  # PATCH/PUT /users/1
  # PATCH/PUT /users/1.json
  def update
    respond_to do |format|
      if @user.update(user_params)
        format.html { redirect_to @user, notice: 'User was successfully updated.' }
        format.json { render :show, status: :ok, location: @user }
      else
        format.html { render :edit }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /users/1
  # DELETE /users/1.json
  def destroy
    @user.destroy
    respond_to do |format|
      format.html { redirect_to users_url, notice: 'User was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
   def user_params
     params.require(:user).permit(:Name, :username, :password)    
   end
end
