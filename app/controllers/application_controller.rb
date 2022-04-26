class ApplicationController < ActionController::Base
  helper_method :current_user, :logged_in?, :admin_user?
  before_action :load_stories
  
  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end 

  def logged_in?
    !!current_user
  end
  
  def admin_user?
    logged_in? && current_user.admin?
  end

  def require_admin_user
    if !logged_in?
      flash[:alert] = "You must be logged in to perform that action"
      redirect_to login_path
    elsif !current_user.admin?
      flash[:alert] = "You must be an admin to perform that action"
      redirect_to root_path      
    end
  end

  private
  def load_stories
    @stories = Story.all
  end

end
