class ApplicationController < ActionController::Base
  protect_from_forgery

  layout :layout_by_resource


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

  protected

  def layout_by_resource
    if devise_controller?
      "static_pages"
    else
      "application"
    end
  end

end
