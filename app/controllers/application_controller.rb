class ApplicationController < ActionController::Base
    before_action :authenticate_user!
    before_action :configure_permitted_parameters, if: :devise_controller?
    before_action :set_notifications, if: :current_user

  protected

  def configure_permitted_parameters
    added_attrs = [:username, :email, :password, :password_confirmation]
    devise_parameter_sanitizer.permit :sign_up, keys: added_attrs
    devise_parameter_sanitizer.permit :sign_in, keys: [:login, :password]
    devise_parameter_sanitizer.permit :account_update, keys:[:avatar, :username, :email, :password, :password_confirmation]
  end

  def set_notifications
    notifications = Notification.includes(:recipient).where(recipient: current_user).newest_first.limit(9)
    @unread = notifications.unread
    @read = notifications.read
  end

    # def after_sign_in_path_for(_resource)
    #   posts_path
    # end
end
