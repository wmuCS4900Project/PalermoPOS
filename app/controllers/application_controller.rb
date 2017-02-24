class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  
  
  def home
    redirect_to '/default/index'
  end
  
  before_filter :require_login

private

  def require_login
    unless current_user || (request.path == login_path) || (request.path == signup_path)
      puts request.path.inspect
      redirect_to login_path, :flash => { :danger => "You must be logged in!" }
    end
  end
end

def current_user
	@current_user ||= User.find_by(id: session[:user_id])
end