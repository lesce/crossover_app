# == Schema Information
#
# Table name: tickets
#
#  id         :integer          not null, primary key
#  title      :string(255)
#  content    :text(65535)
#  status     :integer
#  user_id    :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Indexes
#
#  index_tickets_on_status   (status)
#  index_tickets_on_user_id  (user_id)
#

class Ticket < ApplicationRecord
  # constants
  OPEN = 0
  INPROGRESS = 1
  CLOSED = 2

  enum status: { open: OPEN, in_progress: INPROGRESS, closed: CLOSED }

  # associations
  belongs_to :user

  # validations
  validates_presence_of :title, :content, :user_id

  # callbacks
  before_save :set_default_status

  private

  def set_default_status
    return if self.status.present?
    self.open!
  end
end
