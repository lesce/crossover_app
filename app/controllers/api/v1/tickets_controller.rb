class Api::V1::TicketsController < Api::V1::ApiController
	respond_to :json
  authorize_actions_for Ticket

  def index
    @tickets = Ticket.filter_by_user_role(current_user).all
    render json: @tickets
  end

	def show
    @ticket = Ticket.find_by_id(params[:id])
    authorize_action_for(@ticket)
    render json: @ticket
	end

  def create
    @ticket = Ticket.new ticket_params
    @ticket.user_id = current_user.id
    authorize_action_for(@ticket)
    if @ticket.save
      render json: @ticket, status: 201
    else
      render json: @ticket, status: 304
    end
  end

  def update
    @ticket = Ticket.find_by_id params[:id]
    authorize_action_for(@ticket)
    if @ticket.update_attributes(ticket_params)
      render json: @ticket, status: 200
    else
      render json: @ticket, status: 304
    end
  end

  def destroy
    @ticket = Ticket.find_by_id params[:id]
    authorize_action_for(@ticket)
    if @ticket.destroy
      render json: @ticket, status: 200
    else
      render json: @ticket, status: 304
    end
  end

  def change_status
    @ticket = Ticket.find_by_id params[:id]
    authorize_action_for(@ticket)
    if @ticket.update_attribute(status: params[:status])
      render json: @ticket, status: 200
    else
      render json: @ticket, status: 304
    end
  end

  private

  def ticket_params
    params.require(:ticket).permit(:title, :content)
  end

end
