class RequlMobileAdminsApi
  BASE_URL = "#{Settings.requl_mobile.api_base_url}"
  INTERNAL_BASE_URL = "#{Settings.requl_mobile.api_base_url}/internal"
  APPLICATION_TOKEN = Settings.requl_mobile.application_token

  def initialize(access_token)
    @access_token = access_token
  end

  def me(version: :v1)
    url = "#{INTERNAL_BASE_URL}/#{version}/admins/me"
    response = request(:get, url, { access_token: @access_token, application_token: APPLICATION_TOKEN })
    if response.key?('admin')
      response['admin']
    else
      fail ActiveRecord::RecordNotFound
    end
  end

  def admin_info(admin_id, version: :v1)
    url = "#{INTERNAL_BASE_URL}/#{version}/admins/#{admin_id}"
    response = request(:get, url, { access_token: @access_token, application_token: APPLICATION_TOKEN })
    if response.key?('admin')
      response['admin']
    else
      fail ActiveRecord::RecordNotFound
    end
  end

  def admins(ids, version: :v1)
    url = "#{INTERNAL_BASE_URL}/#{version}/admins/list"
    request(:get, url, { admin_ids: ids, access_token: @access_token, application_token: APPLICATION_TOKEN })
  end

  class << self
    def access_token(email, password, version: :v1)
      url = "#{INTERNAL_BASE_URL}/#{version}/admins/sign_in"
      response = JSON.parse(HTTParty.send(:post, url, { body: { email: email, password: password, application_token: APPLICATION_TOKEN } }).body)
      if response.key?('admin')
        response['admin']['access_token']
      else
        fail ActiveRecord::RecordNotFound
      end
    end
  end

  private

    def request(method, url, params)
      JSON.parse(HTTParty.send(method, url, { body: params }).body)
    end
end
