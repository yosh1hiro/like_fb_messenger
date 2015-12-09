# == Schema Information
#
# Table name: chat_direct_images
#
#  id                  :integer          not null, primary key
#  image               :string(255)      not null
#  sender_id           :integer          not null
#  chat_direct_room_id :integer          not null
#  created_at          :datetime         not null
#  updated_at          :datetime         not null
#
# Indexes
#
#  index_chat_direct_images_on_chat_direct_room_id  (chat_direct_room_id)
#

class ChatDirectImage < ActiveRecord::Base
  include ChatDirect::PostSender
  belongs_to :chat_direct_room
  has_one :chat_post_cache, as: :postable, dependent: :destroy

  mount_uploader :image, ImageUploader

  def save_with_cache!
    save!
    cache!
  end

  def cache!
    build_chat_post_cache(
      chat_room: chat_direct_room,
      sender_id: sender.id,
      sender_type: sender.type,
      image: image,
      posted_at: created_at,
      last_sent_at: created_at,
    ).save!
  end

  def update_room_cache!
    ChatRoomIndexCache.find_by(chat_room: chat_direct_room)
      .try(
        :update,
        last_sent_at: created_at,
        last_sent_message: I18n.t('chat_room_index_cache.last_sent_message_template.image_sent', name: sender.name)
      )
  end
end
