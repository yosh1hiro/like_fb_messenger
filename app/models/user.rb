class User

  class Me
    include ChatModule

    attr_reader :id, :last_name, :first_name, :image, :me

    def initialize(access_token)
      @requl_mobile_api = RequlMobileUsersApi.new(access_token)
    end

    def me(version: 'v3')
      @me ||= @requl_mobile_api.me(version)
    end

    def last_name
      me['last_name']
    end

    def first_name
      me['first_name']
    end

    def image
      me['image']
    end

    def id
      me['id']
    end

    def to_hash
      {
        id: id,
        last_name: last_name,
        first_name: first_name,
        image: image,
      }
    end

    def candidates(page = 1, version: :v1)
      return @candidates if @candidates
      users = @requl_mobile_api.candidates(page, version)
      @candidates = users["users"].map { |user| Other.new(user) }
    end

    def mutually_follow?(target_user_id, version: :v1)
      return @mutually_follow if @mutually_follow

      res = @requl_mobile_api.mutually_follow?(target_user_id, version)
      @mutually_follow = res['mutually_follow']
    end

    class Other
      attr_reader :id, :last_name, :first_name, :image, :user

      def initialize(user_params)
        @id = user_params['id']
        @last_name = user_params['last_name']
        @first_name = user_params['first_name']
        @image = user_params['image']
      end
    end
  end
end
