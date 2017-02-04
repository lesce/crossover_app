class TicketSerializer < ActiveModel::Serializer
  attributes :id, :title, :content, :status, :username, :humanized_status
  belongs_to :user

  def username
    object.user.name
  end

  def humanized_status
    object.status.humanize
  end
end
