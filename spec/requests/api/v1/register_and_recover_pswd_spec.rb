require "rails_helper"

describe "register user and request new password", :type => :request do
  let(:user) { create :user }
  let(:email) { "#{SecureRandom.hex}@gmail.com" }
  let(:new_password) { SecureRandom.hex }

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
    post user_password_path, params: {
      user: {
        email: user.email
      }
    }
    confirmation_mail = ActionMailer::Base.deliveries.last
    # get the confirmation token from email
    uri = URI.parse(URI.extract(confirmation_mail.body.raw_source, /http(s)?/).first)
    token = uri.query.split('=')[1]

    patch user_password_path, params: {
      user: {
        email: user.email,
        password: new_password,
        reset_password_token: token
      }
    }

    expect(response_json['success']).to eq(true)
    expect(response_json['email']).to eq(user.email)
    expect(response_json['auth_token'].present?).to eq(true)
  end
end
