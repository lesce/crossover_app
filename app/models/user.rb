class User < ApplicationRecord
  # constants
  DEFAULT_ROLE = 1
  ADMIN_ROLE = 0

  enum role: { admin: ADMIN_ROLE, default: DEFAULT_ROLE }

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
end
