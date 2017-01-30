# == Schema Information
#
# Table name: users
#
#  id                     :integer          not null, primary key
#  email                  :string(255)      default(""), not null
#  encrypted_password     :string(255)      default(""), not null
#  first_name             :string(255)      not null
#  last_name              :string(255)      not null
#  role                   :integer          default("1"), not null
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

require 'rails_helper'

RSpec.describe User, :type => :model do

  it "requires email address" do
    user = User.create email: nil
    expect(user.errors.messages[:email]).to include('can\'t be blank')
  end

  it "requires a valid email address" do
    user = User.create email: 'not-a-valid-email'
    expect(user.errors.messages[:email]).to include('is invalid')
  end

  it "needs a unique email address" do
    existing_user = create :user
    user = User.create email: existing_user.email
    expect(user.errors.messages[:email]).to include('has already been taken')
  end

  it "requires first name" do
    user = User.create first_name: nil
    expect(user.errors.messages[:first_name]).to include('can\'t be blank')
  end

  it "requires last name" do
    user = User.create last_name: nil
    expect(user.errors.messages[:last_name]).to include('can\'t be blank')
  end

  it "requires password" do
    user = User.create last_name: nil
    expect(user.errors.messages[:last_name]).to include('can\'t be blank')
  end

  it "has a default role" do
    user = create :user
    expect(user.default?).to eq(true)
  end

  it "has an admin role" do
    user = create :admin
    expect(user.admin?).to eq(true)
  end
end
