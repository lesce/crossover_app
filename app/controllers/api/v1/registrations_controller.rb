class Api::V1::RegistrationsController < Devise::RegistrationsController
  respond_to :json
  before_action :configure_sign_up_params, only: [:create]
  before_action :configure_account_update_params, only: [:update]

  # POST /resource
  def create
    build_resource(sign_up_params)

    resource.save
    if resource.persisted?
      render json: {
        success: true,
        auth_token: resource.authentication_token,
        email: resource.email 
      }, status: 201
    else
      render json: { success: false, errors: resource.errors }, status: 401
    end
  end

  # PUT /resource
  def update
    self.resource = resource_class.to_adapter.get!(send(:"current_#{resource_name}").to_key)

    resource_updated = update_resource(resource, account_update_params)
    if resource_updated
      render json: resource, status: 200
    else
      render json: { success: false, errors: resource.errors }, status: 401
    end
  end

  protected

  # If you have extra params to permit, append them to the sanitizer.
  def configure_sign_up_params
    devise_parameter_sanitizer.permit(:sign_up, keys: [:attribute, :first_name, :last_name])
  end

  # If you have extra params to permit, append them to the sanitizer.
  def configure_account_update_params
    devise_parameter_sanitizer.permit(:account_update, keys: [:attribute, :first_name, :last_name])
  end
end
