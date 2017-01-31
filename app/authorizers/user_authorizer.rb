class UserAuthorizer < ApplicationAuthorizer
  # Every admin user can read and update normal users
  def self.default
    user.admin?
  end

  def self.createable_by?(user)
    false
  end

  def self.deletable_by?(user)
    false
  end

  def readable_by?(user)
    user.admin?
  end

end
