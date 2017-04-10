# spec/support/spec_test_helper.rb
module SpecTestHelper   
  def login_admin
    login(:admin)
  end
  
  def create
  	user = User.find_by(username: params[:session][:username].downcase)
    if user && user.authenticate(params[:session][:password])
    	log_in user
      flash[:success] = 'Logged in as ' + :username.to_s
    	redirect_to user
    else
    	flash[:danger] = 'Invalid email/password combination'
    	render 'new'
    end
  end
  
  def destroy
    log_out
    flash[:success] = 'Log out successful'
	  redirect_to :back
    rescue ActionController::RedirectBackError
 	    redirect_to default_index_url
  end

  # Logs in the given user.
  def log_in(user)
    session[:user_id] = user.id
  end
  
  def current_user
	  @current_user ||= User.find_by(id: session[:user_id])
  end
end
