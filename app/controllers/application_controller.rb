class ApplicationController < ActionController::Base
  helper_method :admin_user?
  
  def admin_user?
    # user_signed_in? && current_user.admin?
    true
  end
end
