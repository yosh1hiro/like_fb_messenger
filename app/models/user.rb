module User
  class Me
    include ChatModule

    attr_reader :id, :last_name, :first_name

    def initialize
      @requl_mobile_api = RequlMobileUsersApi.new
    end

    def to_hash
      {
        id: @id,
        last_name: @last_name,
        first_name: @first_name
      }
    end

    def me(access_token, version="v1")
      res = @requl_mobile_api.me(access_token, version)
      @id = res["id"]
      @last_name = res["last_name"]
      @first_name = res["first_name"]
    end

    def candidates(access_token, page="1", version="v1")
      candidates = []
      users = @requl_mobile_api.candidates(access_token, page, version)
      users["users"].each { |user| candidates << Other.new(user) }
      candidates
    end
  end

  class Other
    attr_reader :id, :last_name, :first_name, :image

    def initialize(params = {})
      @requl_mobile_api = RequlMobileUsersApi.new
      @id = params["id"]
      @last_name = params["last_name"]
      @first_name = params["first_name"]
      @image = params["image"]
    end

    def to_hash
      {
        id: @id,
        last_name: @last_name,
        first_name: @first_name,
        image: @image
      }
    end

    def othere
      res = @requl_mobile_api.user_info(access_token, user_id, version)
      @id = res["id"]
      @last_name = res["last_name"]
      @first_name = res["first_name"]
      @image = res["image"]
    end
  end
end
