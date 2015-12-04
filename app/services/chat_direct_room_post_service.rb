class ChatDirectRoomPostService
  attr_accessor :chat_direct_room, :chat_posts, :members

  def initialize(me, chat_room_id, post_page, post_count)
    @me = me

    chat_room = ChatDirectRoom.find(chat_room_id)
    @chat_direct_room = @me.chat_room_index_caches.find_by(chat_room: chat_room)
    @chat_direct_room.room_name = user.name
    @chat_direct_room.room_image = user.image
    @chat_posts = chat_room.chat_post_caches.order(posted_at: :desc).page(post_page).per(post_count)
    senders = chat_room.senders
    @chat_posts.each { |p| p.sender = senders.users_list[p.sender_id] }
    @members = senders.members
    @chat_direct_room
  end

  private

    def user
      @user = FiChat::Member::User.find(member_id, @me.access_token)
    end

    def member_id
      @member_id ||= ChatDirectRoomMember.find_by(chat_direct_room_id: @chat_direct_room.chat_room_id, my_user_id: @me.id).target_user_id
    end
end
