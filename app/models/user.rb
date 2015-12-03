class User
  def initialize
    @requl_mobile_api = RequlMobileUsersApi.new
  end

  def me(access_token, version="v1")
    Users::Me.new(@requl_mobile_api.me(access_token, version))
  end

  def user_info(access_token, user_id, version="v1")
    Users::Other.new(@requl_mobile_api.user_info(access_token, user_id, version))
  end

  def candidates(access_token, page="1", version="v1")
    candidates = []
    users = @requl_mobile_api.candidates(access_token, page, version)
    users["users"].each { |user| candidates << Users::Other.new(user) }
    candidates
  end

  def cendidates_end_flag
    candidate = @requl_mobile_api.candidates(access_token, page, version)
    candidate["end_flag"]
  end
end
