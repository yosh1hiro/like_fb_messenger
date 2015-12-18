module FiChat
  class Member
    class User < FiChat::Member
      def mutually_follow?(other)
        RequlMobileUsersApi.new(@access_token).mutually_follow?(other.id)
      end

      def type
        'User'
      end

      class << self
        def me(access_token)
          me = RequlMobileUsersApi.new(access_token).me
          ::FiChat::Member::User.new(me.merge(me: true, access_token: access_token))
        end

        def find(id, access_token)
          user = RequlMobileUsersApi.new(access_token).user_info(id)
          ::FiChat::Member::User.new(user)
        end

        def find_list(ids)
          users = RequlMobileUsersApi.users(ids)
          fail ActiveRecord::RecordNotFound if users['users'].blank?
          Array(users['users']).map { |u| ::FiChat::Member::User.new(u) }
        end

        def candidates(page, access_token)
          users = RequlMobileUsersApi.new(access_token).candidates(page)
          Array(users['users']).map { |u| ::FiChat::Member::User.new(u) }
        end
      end
    end
  end
end
