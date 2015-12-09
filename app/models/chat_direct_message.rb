# == Schema Information
#
# Table name: chat_direct_messages
#
#  id                  :integer          not null, primary key
#  message             :text(65535)      not null
#  sender_id           :integer          not null
#  chat_direct_room_id :integer          not null
#  created_at          :datetime         not null
#  updated_at          :datetime         not null
#
# Indexes
#
#  index_chat_direct_messages_on_chat_direct_room_id  (chat_direct_room_id)
#

class ChatDirectMessage < ActiveRecord::Base
  include ChatDirect::PostSender
  belongs_to :chat_direct_room
  has_one :chat_post_cache, as: :postable, dependent: :destroy

  validates :message, presence: true

  def save_with_cache!
    save!
    cache!
    update_room_cache!
  end

  def cache!
    build_chat_post_cache(
      chat_room: chat_direct_room,
      sender_id: sender.id,
      sender_type: sender.type,
      message: message,
      posted_at: created_at,
      last_sent_at: created_at,
    ).save!
  end

  def update_room_cache!
    ChatRoomIndexCache.find_by(chat_room: chat_direct_room)
      .try(:update, last_sent_at: created_at, last_sent_message: message)
  end
end
