# frozen_string_literal: true

class Users::RegistrationsController < Devise::RegistrationsController
  # GET /resource/sign_up
  # def new
  #   super
  # end

  # POST /resource
  

  # GET /resource/edit
  # def edit
  #   super
  # end

  # PUT /resource
  def update
    current_user.build_address(address_params) unless current_user.address
    current_user.address.update!(address_params)
    super
  end

  # DELETE /resource
  # def destroy
  #   super
  # end

  # GET /resource/cancel
  # Forces the session data which is usually expired after sign
  # in to be expired now. This is useful if the user wants to
  # cancel oauth signing in/up in the middle of the process,
  # removing all OAuth session data.
  # def cancel
  #   super
  # end


  # If you have extra params to permit, append them to the sanitizer.

  # If you have extra params to permit, append them to the sanitizer.

  # The path used after sign up.


  # The path used after sign up for inactive accounts.
  # def after_inactive_sign_up_path_for(resource)
  #   super(resource)
  # end

  private

  def after_sign_up_path_for(_resource)
    # super(resource)
    after_signup_path('set_name')
  end

  def address_params
    params.require(:address).permit(:id, :street, :city, :state, :zip, :country)
  end
end
