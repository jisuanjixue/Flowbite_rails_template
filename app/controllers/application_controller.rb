class ApplicationController < ActionController::Base
    before_action :authenticate_user!
    before_action :configure_permitted_parameters, if: :devise_controller?
    before_action :set_notifications, if: :current_user
    before_action :set_query

    def is_admin?
      return if current_user&.admin?
        flash[:alert] = 'You are not authorized to perform this action.'
        redirect_to root_path
      
    end

    def set_query
      @query = Post.ransack(params[:q])
    end

  protected

  def configure_permitted_parameters
    added_attrs = [:username, :email, :password, :password_confirmation]
    devise_parameter_sanitizer.permit :sign_up, keys: added_attrs
    devise_parameter_sanitizer.permit :sign_in, keys: [:login, :password]
    devise_parameter_sanitizer.permit :account_update, keys:[:avatar, :username, :email, :password, :password_confirmation, { address: %i[street city state zip country] }]
    devise_parameter_sanitizer.permit(:accept_invitation, keys: [:username])
  end

  def set_notifications
    notifications = Notification.includes(:recipient).where(recipient: current_user).newest_first.limit(9)
    @unread = notifications.unread
    @read = notifications.read
  end

  
end
