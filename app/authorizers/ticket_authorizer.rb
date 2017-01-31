class TicketAuthorizer < ApplicationAuthorizer
  # Every default user can create, read, update and delete tickets
  def self.default(able, user)
    true
  end

  # Admins can't create tickets, they can only read and update
  def self.creatable_by?(user)
    user.default?
  end

  def createable_by?(user)
    user.default?
  end

  def readable_by?(user)
    user.admin? || resource.user_id == user.id
  end

  def updateable_by?(user)
    user.admin? || resource.user_id == user.id
  end

  # Users can delete tickets only if the status hasn't changed
  def deletable_by?(user)
    resource.user_id == user.id && resource.open?
  end

  def moveable_by?(user)
    user.admin?
  end
end
