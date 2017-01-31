require "rails_helper"

describe "sign in", :type => :request do
  describe "POST #create" do
    it "responds successfully with an HTTP 200 status code" do
      ticket = create :ticket
      user = ticket.user
      post user_session_path,
        params: { user: { email: user.email, password: user.password }}.to_json,
        headers: { 'content-type' => 'application/json', 'accept' => 'application/json' }
			response_json = JSON.parse(response.body)

			expect(response_json['success']).to eq(true)
			expect(response_json['auth_token']).to eq(user.authentication_token)
			expect(response_json['email']).to eq(user.email)

      get api_v1_tickets_path, email: user.email, auth_token: user.authentication_token 
			response_json = JSON.parse(response.body)

      expect(response_json['tickets'].id).to include(ticket)
    end
  end
end
