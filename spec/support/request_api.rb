module RequestApi
    def body_json(symbolize_keys: false)
      json = JSON.parse(response.body)
      symbolize_keys ? json.deep_simpolize_keys : json
    rescue
      return {}
    end

    def auth_header(user: nil, merge_with: {})
      user ||= create(:user)
      user.create_new_auth_token.merge({
         "Content-Type" => "application/json",
         "Accept" => "application/json"
        }).merge(merge_with)
    end
end

RSpec.configure do |config|
    config.include RequestApi, type: :request
end