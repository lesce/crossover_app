class Api::V1::ApiController < ApplicationController
  before_action :authenticate_user_from_token

  protected

  def authority_forbidden(error)
    Authority.logger.warn(error.message)
    render json: { message: 'You are not authorized to complete that action.', status: 401 }
  end

  def authenticate_user_from_token
    user_email = params[:email].presence
    user       = user_email && User.find_by_email(user_email)

    # Notice how we use Devise.secure_compare to compare the token
    # in the database with the token given in the params, mitigating
    # timing attacks.
    if user && Devise.secure_compare(user.authentication_token, params[:auth_token])
      sign_in user, store: false
    else
      render json: { message: 'Access Denied.', status: 401 }
    end
  end
end
