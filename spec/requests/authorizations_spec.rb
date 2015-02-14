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

  it 'logs user in' do
    login_user
    assert_response :created
    expect(json_response).to include email: 'user@example.com'
  end

  context 'returns error' do
    it 'when user is not found' do
      login_user(user_invalid_email)
      assert_response :unauthorized
      expect(json_response).to eq error: 'Invalid email or password.'
    end

    it 'when password is incorrect' do
      login_user(user_invalid_password)
      assert_response :unauthorized
      expect(json_response).to eq error: 'Invalid email or password.'
    end
  end
end
