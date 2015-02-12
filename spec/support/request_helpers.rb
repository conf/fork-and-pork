module RequestHelpers

  def login(user)
    post user_session_path, format: :json, user: { email: user.email, password: user.password || '12345678' }
    assert_response :success
  end

  def json_response
    JSON.parse(response.body, symbolize_names: true)
  end
end

RSpec.configure do |config|
  config.include RequestHelpers, type: :request
end
