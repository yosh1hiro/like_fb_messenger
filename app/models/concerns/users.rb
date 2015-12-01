module Users
  class Me
    attr_reader :id, :last_name, :first_name

    def initialize(params = {})
      @id = params[:id]
      @last_name = params[:last_name]
      @first_name = params[:first_name]
    end
  end

  class Other
    attr_reader :id, :last_name, :first_name, :image

    def initialize(params = {})
      @id = params[:id]
      @last_name = params[:last_name]
      @first_name = params[:first_name]
      @image = params[:image]
    end

    def name
      @last_name + @first_name
    end
  end

  class User
    requl_mobile_api = RequlMobileUsersApi.new

    def me(access_token, version="v1")
      Me.new(requl_mobile_api.me(access_token, version))
    end

    def user_info(access_token, user_id, version="v1")
      Other.new(requl_mobile_api.user_info(access_token, user_id, version))
    end

    def candidates(access_token, page="1", version="v1")
      candidates = []
      users = requl_mobile_api.candidates(access_token, page, version)
      users[:users].each { |user| candidates << Other.new(user) }
      @candidates
    end
  end
end
