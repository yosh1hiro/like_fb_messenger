module Public
  module V1
    module Chats
      module Admins
        class Rooms < Grape::API
          get '' do
            case
            when "Admin"
              # @未実装 => adminの情報をgetするinternal apiの実装とapi clientの実装の必要
              @chat_room = ChatDirectWithAdminRoom.find_or_create_by(user_id: me.id, admin_id: 1).chat_room_index_cache
            end
          end
        end
      end
    end
  end
end
