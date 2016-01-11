class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  # For customized error pages
  unless Rails.application.config.consider_all_requests_local
    rescue_from Exception, with: lambda { |exception| render_error 500, exception }
    rescue_from ActionController::RoutingError, ActionController::UnknownController, ::AbstractController::ActionNotFound,  with: lambda { |exception| render_error 404, exception }
  end

  def client_approved?
    authenticate_user!
  	redirect_to clients_unapproved_path unless current_user.approved?
  end

  def resource_signed_in?
    redirect_to root_path unless current_auth_resource
  end

  def current_auth_resource
    if user_signed_in?
      current_user 
    elsif therapist_signed_in?
      current_therapist
    elsif manager_signed_in?
      current_manager
    elsif admin_signed_in?
      current_admin
    end
  end

  private
  def render_error(status, exception)
    respond_to do |format|
      format.html { render template: "errors/error_#{status}", layout: 'layouts/application', status: status }
      format.all { render nothing: true, status: status }
    end
  end
end
