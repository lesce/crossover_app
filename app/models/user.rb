# == Schema Information
#
# Table name: users
#
#  id                     :integer          not null, primary key
#  email                  :string(255)      default(""), not null
#  encrypted_password     :string(255)      default(""), not null
#  first_name             :string(255)      not null
#  last_name              :string(255)      not null
#  role                   :integer          default("0"), not null
#  authentication_token   :string(255)      not null
#  reset_password_token   :string(255)
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#  sign_in_count          :integer          default("0"), not null
#  current_sign_in_at     :datetime
#  last_sign_in_at        :datetime
#  current_sign_in_ip     :string(255)
#  last_sign_in_ip        :string(255)
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#
# Indexes
#
#  index_users_on_email                 (email) UNIQUE
#  index_users_on_reset_password_token  (reset_password_token) UNIQUE
#

class User < ApplicationRecord
  include Authority::UserAbilities

  # constants
  DEFAULT_ROLE = 0
  ADMIN_ROLE = 1

  enum role: { admin: ADMIN_ROLE, default: DEFAULT_ROLE }

  # associations
  has_many :tickets, dependent: :destroy

  # validations
  validates_presence_of :email, :first_name, :last_name
  validates_uniqueness_of :email

  # callbacks
  before_save :set_default_role
  before_save :set_auth_token

  # Include default devise modules. Others available are:
  # :confirmable, :rememberable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :validatable, :trackable

  private

  def set_default_role
    return if self.role.present?
    self.default!
  end
  
  def set_auth_token
    if authentication_token.blank?
      self.authentication_token = generate_authentication_token
    end
  end

  def generate_authentication_token
    loop do
      token = Devise.friendly_token
      break token unless User.where(authentication_token: token).first
    end
  end
end
