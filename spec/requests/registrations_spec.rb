require 'rails_helper'

RSpec.describe "Registration", type: :request do
  describe 'json' do

    let(:valid_user) { { email: 'user@example.com', password: '12345678' } }
    let(:user_invalid_email) { { email: 'user', password: '12345678' } }

    def register_user(user = valid_user)
      post user_registration_path, format: :json, user: user
    end

    def parsed_response
      JSON.parse(response.body)
    end

    it "creates a user" do
      register_user
      expect(response).to have_http_status(201)

      expect(parsed_response['email']).to eq 'user@example.com'
    end

    it 'checks email uniqueness' do
      register_user
      expect(response).to have_http_status(201)

      register_user
      expect(response).to have_http_status(422)
      expect(parsed_response['errors']).to eq('email' => ['has already been taken'])
    end

    it 'checks email validity' do
      register_user(user_invalid_email)
      expect(response).to have_http_status(422)

      expect(parsed_response['errors']).to eq('email' => ['is invalid'])
    end
  end
end
