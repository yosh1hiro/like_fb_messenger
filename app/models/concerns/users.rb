module Users

  def me(access_token, version="v1")

  end

  def user_info(access_token, user_id, version="v1")
    Users::Other.new()
  end

  def candidates(access_token, page="1", version="v1")
    candidates = []
    users = @requl_mobile_api.candidates(access_token, page, version)
    users["users"].each { |user| candidates << Users::Other.new(user) }
    candidates
  end

  def cendidates_end_flag(access_token, page="1", version="v1")
    candidate = @requl_mobile_api.candidates(access_token, page, version)
    candidate["end_flag"]
  end
end
