class ApplicationController < ActionController::Base
    before_action :authenticate_user!
    before_action :configure_permitted_parameters, if: :devise_controller?

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:username, :email, :password, :password_confirmation])
    devise_parameter_sanitizer.permit(:sign_in, keys: [:login, :password]) 
    devise_parameter_sanitizer.permit(:account_update, keys: [:username, :name, :email, :password_confirmation, :current_password])
  end

    # def after_sign_in_path_for(_resource)
    #   posts_path
    # end
end
