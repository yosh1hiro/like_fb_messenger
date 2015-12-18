# == Schema Information
#
# Table name: chat_direct_with_admin_from_admin_images
#
#  id                             :integer          not null, primary key
#  image                          :string(255)      not null
#  chat_direct_with_admin_room_id :integer          not null
#  created_at                     :datetime         not null
#  updated_at                     :datetime         not null
#
# Indexes
#
#  direct_with_admin_from_admin_image  (chat_direct_with_admin_room_id)
#

class ChatDirectWithAdminFromAdminImage < ActiveRecord::Base
  include ChatDirect::PostSender
  belongs_to :chat_direct_with_admin_room
  has_one :chat_post_cache, as: :postable, dependent: :destroy

  mount_uploader :image, ImageUploader

  def save_with_cache!
    save!
    cache!
    update_room_cache!
  end

  def cache!
    cache = ChatPostCache.new(
      chat_room: chat_direct_with_admin_room,
      postable: self,
      sender_id: sender.id,
      sender_type: sender.type,
      image: image,
      posted_at: created_at
    )
    cache.sender = sender
    cache.save!
    true
  end

  def update_room_cache!
    ChatRoomIndexCache.find_by(chat_room: chat_direct_with_admin_room)
      .try(
        :update,
        last_sent_at: created_at,
        last_sent_message: I18n.t('chat_room_index_cache.last_sent_message_template.image_sent', name: sender.name)
      )
  end
end
