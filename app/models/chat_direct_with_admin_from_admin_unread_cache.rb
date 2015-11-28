# == Schema Information
#
# Table name: chat_direct_with_admin_from_admin_unread_caches
#
#  id                             :integer          not null, primary key
#  chat_direct_with_admin_room_id :integer          not null
#  recipient_id                   :integer          not null
#  last_read_at                   :datetime         not null
#  unread_count                   :integer          default(0), not null
#  created_at                     :datetime         not null
#  updated_at                     :datetime         not null
#
# Indexes
#
#  chat_direct_with_admin_room_index        (chat_direct_with_admin_room_id)
#  chat_direct_with_admin_unread_recipient  (recipient_id)
#

class ChatDirectWithAdminFromAdminUnreadCache < ActiveRecord::Base
  belongs_to :chat_direct_with_admin_room
end
