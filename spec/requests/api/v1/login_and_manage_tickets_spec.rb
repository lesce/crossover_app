require "rails_helper"

describe "login and query ticket endpoints", :type => :request do
  context "normal user" do
    let(:ticket) { create :ticket }
    let(:user) { ticket.user }
    let(:title) { 'Test ticket' }
    let(:content) { 'lorem ipsum dolores' }
    let(:updated_title) { 'UPDATED Test ticket' }
    let(:updated_content) { 'UPDATED lorem ipsum dolores' }

    it "responds successfully with an json object after login" do
      post user_session_path,
        params: { user: { email: user.email, password: user.password }}.to_json,
        headers: { 'content-type' => 'application/json', 'accept' => 'application/json' }

      expect(response_json['success']).to eq(true)
      expect(response_json['auth_token']).to eq(user.authentication_token)
      expect(response_json['email']).to eq(user.email)
    end

    it "responds successfully with 401 Unauthorized" do
      post user_session_path,
        params: { user: { email: 'fail@test.com', password: SecureRandom.hex }}.to_json,
        headers: { 'content-type' => 'application/json', 'accept' => 'application/json' }

      expect(response_json['success']).to eq(false)
    end

    it "gets all user tickets" do
      get api_v1_tickets_path, params: { 
        email: user.email,
        auth_token: user.authentication_token
      }

      expect(response_json['tickets'].first['id']).to eq(ticket.id)
    end

    it "gets specific ticket" do
      get api_v1_ticket_path(ticket), params: { 
        email: user.email,
        auth_token: user.authentication_token
      }

      expect(response_json['ticket']['id']).to eq(ticket.id)
    end

    it "creates a ticket through endpoint" do
      post api_v1_tickets_path, params: {
        email: user.email,
        auth_token: user.authentication_token,
        ticket: {
          title: title,
          content: content 
        }
      }

      expect(response_json['ticket']['id'].present?).to eq(true)
      expect(response_json['ticket']['title']).to eq(title)
      expect(response_json['ticket']['content']).to eq(content)
      expect(response_json['ticket']['user']['id']).to eq(user.id)
    end

    it "updates a ticket through endpoint" do
      patch api_v1_ticket_path(ticket.id), params: {
        email: user.email,
        auth_token: user.authentication_token,
        ticket: {
          title: updated_title,
          content: updated_content 
        }
      }
    end

    it "removes a ticket through endpoint" do
      delete api_v1_ticket_path(ticket.id), params: {
        email: user.email,
        auth_token: user.authentication_token
      }

      expect(response.status).to eq(200)
    end

    it "gets unauthorized 403 response if it tries to get a ticket from another user" do
      unauthorized_ticket = create :ticket
      # get specific ticket
      get api_v1_ticket_path(unauthorized_ticket), params: { 
        email: user.email,
        auth_token: user.authentication_token
      }

      expect(response.status).to eq(403)
      expect(response_json['message']).to eq('You are not authorized to complete that action.')
    end

    it "gets unauthorized 403 if it tries to change ticket status" do
      patch change_status_api_v1_ticket_path(ticket), params: { 
        email: user.email,
        auth_token: user.authentication_token,
        status: Ticket::INPROGRESS
      }

      expect(response.status).to eq(403)
      expect(response_json['message']).to eq('You are not authorized to complete that action.')
    end
  end

  context "admin" do
    let(:user) { create :admin }
    let(:number_of_tickets) { 10 }

    it "logs in admin user" do
      post user_session_path,
        params: { user: { email: user.email, password: user.password }}.to_json,
        headers: { 'content-type' => 'application/json', 'accept' => 'application/json' }

      expect(response_json['success']).to eq(true)
      expect(response_json['auth_token']).to eq(user.authentication_token)
      expect(response_json['email']).to eq(user.email)
    end

    it "responds successfully with all available tickets" do
      number_of_tickets.times { create :ticket }

      get api_v1_tickets_path, params: {
        email: user.email,
        auth_token: user.authentication_token
      }

      expect(response_json['tickets'].count).to eq(number_of_tickets)
    end
  end
end
