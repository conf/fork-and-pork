require 'rails_helper'

RSpec.describe "Authorization", type: :request do

  let!(:valid_user) { { email: 'user@example.com', password: '12345678' } }
  let(:user_invalid_email) { { email: 'another_user@example.com', password: '12345678' } }
  let(:user_invalid_password) { { email: 'user@example.com', password: '123' } }

  before do
    FactoryGirl.create(:user, valid_user)
  end

  def login_user(user = valid_user)
    post user_session_path, format: :json, user: user
  end

  def parsed_response
    JSON.parse(response.body)
  end

  it 'logs user in' do
    login_user
    expect(response).to have_http_status(201)
    expect(parsed_response['email']).to eq 'user@example.com'
  end

  context 'returns error' do
    it 'when user is not found' do
      login_user(user_invalid_email)
      expect(response).to have_http_status(401)
      expect(parsed_response['error']).to eq 'Invalid email or password.'
    end

    it 'when password is incorrect' do
      login_user(user_invalid_password)
      expect(response).to have_http_status(401)
      expect(parsed_response['error']).to eq 'Invalid email or password.'
    end
  end
end
