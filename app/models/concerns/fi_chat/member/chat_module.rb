module FiChat
  class Member
    module ChatModule
      def direct_chat_rooms
        direct_room_ids = ChatDirectRoomMember.where(my_user_id: id).pluck(:chat_direct_room_id)
        ChatDirectRoom.where(id: direct_room_ids)
      end

      def direct_admin_chat_rooms
        ChatDirectWithAdminRoom.where(user_id: id)  # self.idはerrorでるかも。未確認
      end

      def chat_room_index_caches
        ChatRoomIndexCache.where(chat_room: direct_chat_rooms)
      end
    end
  end
end
