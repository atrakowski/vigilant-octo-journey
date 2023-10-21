# frozen_string_literal: true

class Customers::RegistrationsController < Devise::RegistrationsController
  before_action :configure_sign_up_params, only: [:create]
  before_action :configure_account_update_params, only: [:update]

  protected

  # If you have extra params to permit, append them to the sanitizer.
  def configure_sign_up_params
    devise_parameter_sanitizer.permit(:sign_up, keys: additional_customer_attributes)
  end

  # If you have extra params to permit, append them to the sanitizer.
  def configure_account_update_params
    devise_parameter_sanitizer.permit(:account_update, keys: additional_customer_attributes)
  end

  private

  def additional_customer_attributes
    [
      :first_name,
      :last_name,
      :born_on,
      :street,
      :zip_code,
      :city,
    ]
  end
end
