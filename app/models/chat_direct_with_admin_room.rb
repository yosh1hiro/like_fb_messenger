# == Schema Information
#
# Table name: chat_direct_with_admin_rooms
#
#  id         :integer          not null, primary key
#  user_id    :integer          not null
#  admin_id   :integer          not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Indexes
#
#  index_chat_direct_with_admin_rooms_on_user_id  (user_id)
#

class ChatDirectWithAdminRoom < ActiveRecord::Base
  has_many :chat_direct_with_admin_messages, dependent: :destroy
  has_many :chat_direct_with_admin_from_admin_messages, dependent: :destroy
  has_many :chat_direct_with_admin_images, dependent: :destroy
  has_many :chat_direct_with_admin_from_admin_images, dependent: :destroy
  has_many :chat_direct_with_admin_stamps, dependent: :destroy
  has_many :chat_direct_with_admin_from_admin_stamps, dependent: :destroy
  has_one :chat_room_index_cache, as: :chat_room, dependent: :destroy

  def target_type
    'Admin'
  end

  class << self
    def find_or_create_by(user, admin)
      chat_room = ChatDirectWithAdminRoom.find_or_initialize_by(user_id: user.id, admin_id: admin.id)
      return chat_room if chat_room.persisted?

      chat_room.save!
      chat_room
    end
  end
end
