# == Schema Information
#
# Table name: chat_direct_with_admin_images
#
#  id                             :integer          not null, primary key
#  image                          :string(255)      not null
#  chat_direct_with_admin_room_id :integer          not null
#  created_at                     :datetime         not null
#  updated_at                     :datetime         not null
#
# Indexes
#
#  direct_with_admin_image  (chat_direct_with_admin_room_id)
#

class ChatDirectWithAdminImage < ActiveRecord::Base
  belongs_to :chat_direct_with_admin_room
  has_one :chat_post_cache, as: :postable, dependent: :destroy
  mount_uploader :image, ImageUploader
end
