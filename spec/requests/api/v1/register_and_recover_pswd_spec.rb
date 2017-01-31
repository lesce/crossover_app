require "rails_helper"

describe "register user and request new password", :type => :request do
  let(:user) { create :user }
  let(:email) { "#{SecureRandom.hex}@gmail.com" }

  it "registers a new user" do
    post user_registration_path, params: { 
      user: {
        email: email,
        password: SecureRandom.hex,
        first_name: 'Test',
        last_name: 'Doe'
      }
    }

    expect(response_json['success']).to eq(true)
    expect(response_json['email']).to eq(email)
    expect(response_json['auth_token'].present?).to eq(true)
  end

  it "tries to register a new user with an existing email" do
    post user_registration_path, params: { 
      user: {
        email: user.email,
        password: SecureRandom.hex,
        first_name: 'Test',
        last_name: 'Doe'
      }
    }

    expect(response_json['success']).to eq(false)
    expect(response_json['errors']['email']).to include('has already been taken')
  end

  it "requests a new password" do
  end
end
