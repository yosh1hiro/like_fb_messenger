# == Schema Information
#
# Table name: chat_direct_with_admin_stamps
#
#  id                             :integer          not null, primary key
#  stamp_id                       :integer          not null
#  chat_direct_with_admin_room_id :integer          not null
#  created_at                     :datetime         not null
#  updated_at                     :datetime         not null
#
# Indexes
#
#  direct_with_admin_stamp  (chat_direct_with_admin_room_id)
#

class ChatDirectWithAdminStamp < ActiveRecord::Base
  belongs_to :chat_direct_with_admin_room
end
