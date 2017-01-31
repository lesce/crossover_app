class Api::V1::TicketsController < Api::V1::ApiController
	respond_to :json
  authorize_actions_for Ticket

  def index
    @tickets = Ticket.where(user_id: current_user.id).all
    render json: { tickets: @tickets }
  end

	def show
	end

  def create
  end

  def update
  end

  def destroy
  end
end
