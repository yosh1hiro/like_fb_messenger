module WithAdmin
  class ChatDirectRoomPostedAfterService
    attr_accessor :chat_direct_room, :chat_posts, :members

    def initialize(me, chat_room_id, posted_after)
      @me = me

      @chat_room = ChatDirectWithAdminRoom.find(chat_room_id)
      @chat_direct_room = @me.chat_room_with_admin_index_caches.find_by(chat_room: @chat_room)
      @chat_direct_room.room_name = admin.name
      @chat_direct_room.room_image = admin.image
      @chat_posts = @chat_room.chat_post_caches.where('posted_at > ?', posted_after)
      members = FiChat::Members.new([me, admin])
      @members = members.members
      @chat_posts.each { |p| p.sender = members.find_by_type(p.sender_type, p.sender_id) }
      @chat_direct_room
    end

    private

      def admin
        @admin = FiChat::Member::Admin.new({ 'id' => 1, 'last_name' => 'sample', 'first_name' => 'admin' }) # TODO: implement
        @admin ||= FiChat::Member::Admin.find(@chat_room.admin_id)
      end
  end
end
