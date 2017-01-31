class Api::V1::PasswordsController < Devise::PasswordsController
  respond_to :json

  # POST /resource/password
  def create
    self.resource = resource_class.send_reset_password_instructions(resource_params)

    if successfully_sent?(resource)
      render json: { success: true,  }, status: 200
    else
      render json: { success: false, errors: resource.errors }, status: 304
    end
  end

  # PUT /resource/password
  def update
    self.resource = resource_class.reset_password_by_token(resource_params)

    if resource.errors.empty?
      render json: { 
        success: true,
        auth_token: resource.authentication_token,
        email: resource.email 
      }, status: 200
    else
      render json: { success: false, errors: resource.errors }, status: 304
    end
  end
end
