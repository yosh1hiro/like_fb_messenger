class ChatDirectRoomService
  attr_accessor :users_list, :chat_direct_room, :chat_posts, :members

  def initialize(me)
    @me = me
  end

  def chat_direct_rooms
    return @chat_direct_rooms if @chat_direct_rooms

    @chat_direct_rooms = @me.chat_room_index_caches
    @chat_direct_rooms.each do |r|
      case r.chat_room_type
      when 'ChatDirectRoom'
        user_id = member_id_by_room_id[r.chat_room_id]
        user = users_list[user_id]
        r.room_name = user.name
        r.room_image = user.image
      end
    end
  end

  private

    def users_list
      return @users_list if @users_list

      members = FiChat::Member::User.find_list(member_id_by_room_id.map { |_, m_id| m_id } )
      @users_list = FiChat::Members.new(members).users_list
    end

    def member_id_by_room_id
      @member_id_by_room_id ||= ChatDirectRoomMember.where(chat_direct_room_id: @chat_direct_rooms.pluck(:chat_room_id))
        .where(my_user_id: @me.id).pluck(:chat_direct_room_id, :target_user_id).to_h
    end
end
