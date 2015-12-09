class RequlMobileAdminApi
  BASE_URL = "#{Settings.requl_mobile.api_base_url}"
  INTERNAL_BASE_URL = "#{Settings.requl_mobile.api_base_url}/internal"
  APPLICATION_TOKEN = Settings.requl_mobile.application_token

  def initialize
  end

  def admin_info(admin_id, version: :v1)
    url = "#{INTERNAL_BASE_URL}/#{version}/admins/#{admin_id}"
    response = request(:get, url, { application_token: APPLICATION_TOKEN })
    if response.key?('admin')
      response['admin']
    else
      fail ActiveRecord::RecordNotFound
    end
  end

  class << self
    def admins(ids, version: :v1)
      url = "#{INTERNAL_BASE_URL}/#{version}/admins/list"
      JSON.parse(HTTParty.send(:get, url, { body: { admin_ids: ids, application_token: APPLICATION_TOKEN } }).body)
    end
  end

  private

    def request(method, url, params)
      JSON.parse(HTTParty.send(method, url, { body: params }).body)
    end
end
