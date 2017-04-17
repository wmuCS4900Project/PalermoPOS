class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy]

  # Flash messages
   use_growlyflash

  # GET /users
  # GET /users.json
  def index
    if ( !logged_in? || !current_user.can?("view", "users"))
      redirect_to default_index_url, :flash => { :danger => "You do not have permission to do this!" }
      return
    end
    
    @users = User.all
  end

  # GET /users/1
  # GET /users/1.json
  def show
    if ( !logged_in? || !current_user.can?("view", "users"))
      redirect_to default_index_url, :flash => { :danger => "You do not have permission to do this!" }
      return
    end
  end

  # GET /users/new
  def new
    if ( !logged_in? || !current_user.can?("create", "users"))
      redirect_to users_url, :flash => { :danger => "You do not have permission to do this!" }
      return
    end
    
    @user = User.new
    @roles = Role.all
  end

  # GET /users/1/edit
  def edit
    if ( !logged_in? || !current_user.can?("edit", "users"))
      flash[:danger] = "You don't have permissions for this"
      redirect_to users_url, :flash => { :danger => "You do not have permission to do this!" }
      return
    end
    
    @roles = Role.all
  end

  # POST /users
  # POST /users.json
  def create
    # Check Capabilities
    if ( !logged_in? || !current_user.can?("create", "users"))
      redirect_to users_url, :flash => { :danger => "You do not have permission to do this!" }
      return
    end

    # Get roles from params 
    args = { :Name => params[:user][:Name] , :username => params[:user][:username], :password => params[:user][:password] }
    @user = User.new( args )
      if @user.save
        # Add Roles that were checked
        if params["roles"].present?
          roles = params["roles"]

          roles.each do |role|
            @user.add_role(role)
          end
        end

        flash[:success] = "User successfully added"
        redirect_to @user
        return

      else
        flash[:danger] = "Error: Could not add user" # TODO: More meaningful message
        redirect_to users_path
        return
      end
  end

  # PATCH/PUT /users/1
  # PATCH/PUT /users/1.json
  def update
    # Check Capabilities
    if ( !logged_in? || !current_user.can?("edit", "users"))
      redirect_to users_url, :flash => { :danger => "You do not have permission to do this!" }
      return
    end

    # If blank, don't change password
    if user_params["password"].blank?
      puts "BLANK-----"
      user_params.delete "password"
      user_params.delete :password
      params[:user].delete :password
    end 

    puts user_params.inspect

    roles = params["roles"]

    if @user.update(user_params)
      # Remove roles 

      user_roles = @user.roles
      user_roles.each do |role|
        @user.remove_role(role.name)
      end

      # Add Roles that were checked
      if (roles != nil)
        roles.each do |role|
          @user.add_role(role)
        end
      end

      flash[:success] = "User successfully updated"
    else
      flash[:danger] = @user.errors
    end
    
    redirect_to @user
    return
  end

  # DELETE /users/1
  # DELETE /users/1.json
  def destroy
    # Check Capabilities
    if ( !logged_in? || !current_user.can?("destroy", "users"))
      redirect_to users_url, :flash => { :danger => "You do not have permission to do this!" }
      return
    end

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
