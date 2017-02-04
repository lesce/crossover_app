class Api::V1::UsersController < Api::V1::ApiController
  respond_to :json
  authorize_actions_for User

  def index
    @users = User.default.all
    render json: @users
  end

  def show
    @user = User.find_by_id params[:id]
    authorize_action_for(@user)
    render json: @user
  end

  def update
    @user = User.find_by_id params[:id]
    authorize_action_for(@user)
    if @user.update_attributes user_params
      render json: @user, status: 200
    else
      render json: @user, status: 304
    end
  end

  private

  def user_params
    params.require(:user).permit(:first_name, :last_name, :role, :note)
  end
end
