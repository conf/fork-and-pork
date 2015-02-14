require 'rails_helper'

RSpec.describe "Calories", type: :request do

  let(:user) { FactoryGirl.create(:user) }

  before do
    login(user)
  end

  it 'GET /calories' do
    get calories_path, format: :json
    assert_response :success
    expect(json_response[:calories]).to eq 200
  end

  it 'PATCH /calories' do
    expect do
      patch calories_path, format: :json, user: { calories: 300 }
    end.to change { user.reload.calories }.from(200).to(300)
  end

end
