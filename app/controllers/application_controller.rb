require "application_responder"

class ApplicationController < ActionController::Base
  # acts_as_token_authentication_handler_for User
  self.responder = ApplicationResponder
  respond_to :html

  before_action :set_paper_trail_whodunnit
  protect_from_forgery with: :exception

  # Issues with configuration with devise.
  before_action :configure_sanitized_params, if: :devise_controller?

  rescue_from CanCan::AccessDenied do |exception|
    redirect_to main_app.root_path, :alert => "Access Denied"
  end


  protected

    # Adds affiliation to permitted params for devise sign up

    def configure_sanitized_params
      devise_parameter_sanitizer.permit(:sign_up, keys: [:email, :password, :password_confirmation, :affiliation])
    end


end
