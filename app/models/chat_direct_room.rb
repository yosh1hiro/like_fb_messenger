# == Schema Information
#
# Table name: chat_direct_rooms
#
#  id         :integer          not null, primary key
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class ChatDirectRoom < ActiveRecord::Base
  attr_accessor :target_user
  attr_reader :senders

  has_many :chat_direct_room_members, dependent: :destroy
  has_many :chat_direct_messages, dependent: :destroy
  has_many :chat_direct_images, dependent: :destroy
  has_many :chat_direct_stamps, dependent: :destroy
  has_one :chat_room_index_cache, as: :chat_room, dependent: :destroy
  has_many :chat_post_caches, as: :chat_room, dependent: :destroy

  def target_type
    target_user.try(:type)
  end

  def target_id
    target_user.try(:id)
  end

  def image
    target_user.try(:image)
  end

  def name
    target_user.try(:name)
  end

  def senders
    return @senders if @senders
    user_ids = chat_direct_room_members.pluck(:target_user_id)
    @senders = FiChat::Members.new(FiChat::Member::User.find_list(user_ids))
  end

  class << self
    def find_or_create_by(my_user, target_user)
      if direct_room_member = ChatDirectRoomMember.find_by(my_user_id: my_user.id, target_user_id: target_user.id)
        direct_room_member.chat_direct_room
      else
        chat_room = ChatDirectRoom.new
        chat_room.target_user = target_user
        ActiveRecord::Base.transaction do
          chat_room.save!
          chat_room.chat_direct_room_members.create(my_user_id: my_user.id, target_user_id: target_user.id)
          chat_room.chat_direct_room_members.create(my_user_id: target_user.id, target_user_id: my_user.id)
          chat_room.build_chat_room_index_cache(name: "#{my_user.last_name}#{my_user.first_name} / #{target_user.last_name}#{target_user.first_name}", target_type: chat_room.target_type).save!
        end
        chat_room
      end
    end
  end
end
