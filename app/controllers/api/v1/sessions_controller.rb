class Api::V1::SessionsController < Devise::SessionsController
  respond_to :json

  # POST /resource/sign_in
  def create
    self.resource = warden.authenticate!(auth_options)
    if sign_in(resource_name, resource, store: false)
      render json: {
        success: true,
        auth_token: resource.authentication_token,
        email: resource.email 
      }
    else
      render json: { success: false }, status: 401
    end
  end

end
