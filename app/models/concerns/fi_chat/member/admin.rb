module FiChat
  class Member
    class Admin < FiChat::Member
      def type
        'Admin'
      end

      class << self
        def me(access_token)
          me = RequlMobileAdminsApi.new(access_token).me
          ::FiChat::Member::Admin.new(me)
        end

        def find(id, access_token)
          admin = RequlMobileAdminsApi.new(access_token).admin_info(id)
          ::FiChat::Member::Admin.new(admin)
        end

        def find_list(ids, access_token)
          admins = RequlMobileAdminsApi.new(access_token).admins(ids)
          fail ActiveRecord::RecordNotFound if admins['admins'].blank?
          Array(admins['admins']).map { |a| ::FiChat::Member::Admin.new(a) }
        end
      end
    end
  end
end
