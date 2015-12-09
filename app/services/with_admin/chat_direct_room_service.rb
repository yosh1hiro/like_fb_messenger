module WithAdmin
  class ChatDirectRoomService
    attr_accessor :users_list, :chat_direct_room, :chat_posts, :members

    def initialize(me, page, count)
      @me = me
      @page = page
      @count = count
      @chat_direct_rooms = chat_direct_rooms
    end

    def chat_direct_rooms
      return @chat_direct_rooms if @chat_direct_rooms

      @chat_direct_rooms = @me.chat_room_with_admin_index_caches
        .page(@page).per(@count)
      @chat_direct_rooms.each do |r|
        r.room_name = 'admin name' # TODO: admin.name
        r.room_image = nil # TODO: admin.image
      end
    end
  end
end
