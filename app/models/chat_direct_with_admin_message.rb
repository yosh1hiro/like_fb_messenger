# == Schema Information
#
# Table name: chat_direct_with_admin_messages
#
#  id                             :integer          not null, primary key
#  message                        :text(65535)      not null
#  chat_direct_with_admin_room_id :integer          not null
#  created_at                     :datetime         not null
#  updated_at                     :datetime         not null
#
# Indexes
#
#  direct_admin_message  (chat_direct_with_admin_room_id)
#

class ChatDirectWithAdminMessage < ActiveRecord::Base
  belongs_to :chat_direct_with_admin_room
  has_one :chat_post_cache, as: :postable, dependent: :destroy

  validates :message, presence: true
end
