module RequlMobileUsersApi

  BASE_URL = "#{Settings.requl_modile.api_base_url}/internal"

  class << self
    def me(access_token, version="v1")
      url = "#{BASE_URL}/#{version}/users/me"
      response = request(:get, url, { access_token: access_token })
      if response.has_key?(:user)
        response[:user]
      else
        raise ActiveRecord::RecordNotFound
      end
    end

    def user_info(access_token, user_id, version="v1")
      url = "#{BASE_URL}/#{version}/users/#{user_id}"
      response = request(:get, url, { access_token: access_token, user_id: user_id})
      if response.has_key?(:user)
        response[:user]
      else
        raise ActiveRecord::RecordNotFound
      end
    end

    def mutually_follow?(access_token, target_user_id, version="v1")
      url = "#{BASE_URL}/#{version}/users/confirm_mutually_follow"
      request(:get, url, {access_token: access_token, target_user_id: target_user_id})
    end

    def candidates(access_token, page="1", version="v1")
      url = "#{BASE_URL}/#{version}/users/mutually_follows_list"
      request(:get, url, {access_token: access_token, page: page})
      if response.has_key?(:user)
        response[:user]
      else
        raise ActiveRecord::RecordNotFound
      end
    end
  end

  private

  def self.request(method, url, params)
    JSON.parse(HTTParty.send(method, url, { body: params }).body)
  end
end
