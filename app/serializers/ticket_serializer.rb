class TicketSerializer < ActiveModel::Serializer
  attributes :id, :title, :content, :status
  belongs_to :user
end
