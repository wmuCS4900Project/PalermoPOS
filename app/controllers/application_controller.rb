class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  # Returns the current logged-in user (if any).
  def current_user
  	user = @current_user ||= User.find_by(id: session[:user_id])
  end

  # Returns true if the user is logged in, false otherwise.
  def logged_in?
    !current_user.nil?  
  end
  
  def home
    redirect_to '/default/index'
  end
  
   before_filter :require_login

  private
    def require_login
      unless current_user || (request.path == login_path)
        puts request.path.inspect
        redirect_to login_path, :flash => { :danger => "You must be logged in!" }
      end
    end
  end

end