require 'rails_helper'

RSpec.describe "Registration", type: :request do
  describe 'json' do

    let(:valid_user) { { email: 'user@example.com', password: '12345678' } }
    let(:user_invalid_email) { { email: 'user', password: '12345678' } }

    def register_user(user = valid_user)
      post user_registration_path, format: :json, user: user
    end

    it "creates a user" do
      register_user
      assert_response :created

      expect(json_response).to include email: 'user@example.com'
    end

    it 'checks email uniqueness' do
      register_user
      assert_response :created

      register_user
      assert_response :unprocessable_entity
      expect(json_response[:errors]).to eq email: ['has already been taken']
    end

    it 'checks email validity' do
      register_user(user_invalid_email)
      assert_response :unprocessable_entity

      expect(json_response[:errors]).to eq email: ['is invalid']
    end
  end
end
