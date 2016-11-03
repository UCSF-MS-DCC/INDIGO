class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  # Issues with configuration with devise.
  before_filter :configure_sanitized_params, if: :devise_controller?

  # Adds affiliation to permitted params for devise sign up

  protected

    def configure_sanitized_params
      devise_parameter_sanitizer.permit(:sign_up, keys: [:email, :password, :password_confirmation, :affiliation])
    end


end
