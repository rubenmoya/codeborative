class Users::RegistrationsController < Devise::RegistrationsController
  before_action :configure_sign_up_params, only: [:create]
  before_action :configure_account_update_params, only: [:update]

  protected

  def configure_sign_up_params
    devise_parameter_sanitizer.for(:sign_up)
                              .push(:name, :avatar, :location, :company, :twitter, :github)
  end

  def configure_account_update_params
    devise_parameter_sanitizer.for(:account_update)
                              .push(:name, :avatar, :location, :company, :twitter, :github)
  end

  def update_resource(resource, params)
    resource.update_without_password(params)
  end
end
