module ChatModule
  def direct_chat_rooms
    direct_room_ids = ChatDirectRoomMember.where(my_user_id: self.id).pluck(:id)  # self.idはerrorでるかも。未確認
    ChatDirectRoom.where(id: direct_room_ids)
  end

  def direct_admin_chat_rooms
    ChatDirectWithAdminRoom.where(user_id: self.id)  # self.idはerrorでるかも。未確認
  end

  def chat_room_index_caches
    ChatRoomIndexCache.where(chat_room: [direct_chat_rooms, direct_admin_chat_rooms])
  end
end
