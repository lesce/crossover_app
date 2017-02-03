class TicketSerializer < ActiveModel::Serializer
  attributes :id, :title, :content, :status, :username
  belongs_to :user

  def username
    object.user.name
  end
end
