require "rails_helper"

describe 'manage users' do
  let(:admin) { create :admin }
  let(:user) { create :user }
  let(:number_of_users) { 10 }

  it "gets all normal users" do
    number_of_users.times { create :user }

    get api_v1_users_path, params: {
      email: admin.email,
      auth_token: admin.authentication_token
    }

    expect(response_json['users'].count).to eq(number_of_users)
  end

  it "gets specific normal user" do
    get api_v1_user_path(user), params: {
      email: admin.email,
      auth_token: admin.authentication_token
    }

    expect(response_json['user']['email']).to eq(user.email)
  end

  it "gets 403 reponse if trying to access another admin info" do
    other_admin_user = create :admin

    get api_v1_user_path(other_admin_user), params: {
      email: admin.email,
      auth_token: admin.authentication_token
    }

    expect(response_json['status']).to eq(403)
    expect(response_json['message']).to eq('You are not authorized to complete that action.')
  end

  it "updates user to admin role" do
    patch api_v1_user_path(user), params: {
      email: admin.email,
      auth_token: admin.authentication_token,
      user: {
        role: User::ADMIN_ROLE
      }
    }.to_json, headers: { 'content-type' => 'application/json' }

    user.reload

    expect(user.admin?).to eq(true)
  end
end
