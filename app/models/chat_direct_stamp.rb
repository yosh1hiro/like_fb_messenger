# == Schema Information
#
# Table name: chat_direct_stamps
#
#  id                  :integer          not null, primary key
#  stamp_id            :integer          not null
#  sender_id           :integer          not null
#  chat_direct_room_id :integer          not null
#  created_at          :datetime         not null
#  updated_at          :datetime         not null
#
# Indexes
#
#  index_chat_direct_stamps_on_chat_direct_room_id  (chat_direct_room_id)
#

class ChatDirectStamp < ActiveRecord::Base
  include ChatDirect::PostSender
  belongs_to :chat_direct_room
  has_one :chat_post_cache, as: :postable, dependent: :destroy

  def save_with_cache!
    save!
    cache!
  end

  def cache!
    build_chat_post_cache(
      chat_room: chat_direct_room,
      sender_id: sender.id,
      sender_type: sender.type,
      stamp_id: stamp_id,
      posted_at: created_at,
    ).save!
  end
end
