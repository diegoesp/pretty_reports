class ApplicationController < ActionController::Base
  protect_from_forgery

  http_basic_authenticate_with :name => "user", :password => "lacasadelarte"

  # Hook for active admin for using my own User model
  def authenticate_admin_user!
    authenticate_user!
    unless current_user.admin?
      flash[:alert] = "This area is restricted to administrators only"
      redirect_to root_path
    end
  end
 
  # Hook for active admin for using my own User model
  def current_admin_user
    return nil if user_signed_in? && !current_user.admin?
    current_user
  end

end
