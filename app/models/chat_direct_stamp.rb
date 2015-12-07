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
end
