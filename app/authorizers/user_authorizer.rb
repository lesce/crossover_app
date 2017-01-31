class UserAuthorizer < ApplicationAuthorizer
  # Every admin user can read and update normal users
  def self.default(able, user)
    user.admin?
  end

  def readable_by?(user)
    user.admin? && resource.default?
  end

  def updateable_by?(user)
    user.admin? && resource.default?
  end
end
