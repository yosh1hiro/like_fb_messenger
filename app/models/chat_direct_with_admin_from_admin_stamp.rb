# == Schema Information
#
# Table name: chat_direct_with_admin_from_admin_stamps
#
#  id                             :integer          not null, primary key
#  stamp_id                       :integer          not null
#  chat_direct_with_admin_room_id :integer          not null
#  created_at                     :datetime         not null
#  updated_at                     :datetime         not null
#
# Indexes
#
#  direct_with_admin_from_admin_stamp  (chat_direct_with_admin_room_id)
#

class ChatDirectWithAdminFromAdminStamp < ActiveRecord::Base
  include ChatDirect::PostSender
  belongs_to :chat_direct_with_admin_room
  has_one :chat_post_cache, as: :postable, dependent: :destroy

  def save_with_cache!
    save!
    cache!
    update_room_cache!
  end

  def cache!
    build_chat_post_cache(
      chat_room: chat_direct_with_admin_room,
      sender_id: sender.id,
      sender_type: sender.type,
      stamp_id: stamp_id,
      posted_at: created_at,
    ).save!
    chat_post_cache.sender = sender
  end

  def update_room_cache!
    ChatRoomIndexCache.find_by(chat_room: chat_direct_with_admin_room)
      .try(
        :update,
        last_sent_at: created_at,
        last_sent_message: I18n.t('chat_room_index_cache.last_sent_message_template.stamp_sent', name: sender.name)
      )
  end
end
