class Api::V1::SessionsController < Devise::SessionsController
  respond_to :json

  # POST /resource/sign_in
  def create
    resource = User.find_for_database_authentication(email: params[:user][:email])
    if resource && resource.valid_password?(params[:user][:password])
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
