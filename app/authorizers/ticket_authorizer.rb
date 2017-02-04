class TicketAuthorizer < ApplicationAuthorizer
  # Every default user can create, read, update and delete tickets
  def self.default(able, user)
    true
  end

  def self.creatable_by?(user)
    true
  end

  def createable_by?(user)
    true
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
