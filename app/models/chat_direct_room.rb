# == Schema Information
#
# Table name: chat_direct_rooms
#
#  id         :integer          not null, primary key
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class ChatDirectRoom < ActiveRecord::Base
  has_many :chat_direct_room_members, dependent: :destroy
  has_many :chat_direct_messages, dependent: :destroy
  has_many :chat_direct_images, dependent: :destroy
  has_many :chat_direct_stamp, dependent: :destroy
  has_one :chat_room_index_caches, as: :chat_room, dependent: :destroy

  def self.find_or_create_by(my_user, target_user)
    if direct_room_member = ChatDirectRoomMember.find_by(my_user_id: my_user.id, target_user_id: target_user.id)
      direct_room_member.chat_room
    else
      chat_room = ChatDirectRoom.new
      ActiveRecord::Base.transaction do
        chat_room.save!
        chat_room.chat_direct_room_members.create(my_user_id: my_user.id, target_user_id: target_user.id)
        chat_room.chat_direct_room_members.create(my_user_id: target_user.id, target_user_id: my_user.id)
      end
      chat_room
    end
  end
end
