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
  has_one :chat_room_index_caches, as: :chat_room, dependent: :destroy
end
