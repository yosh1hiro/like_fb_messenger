# == Schema Information
#
# Table name: chat_direct_messages
#
#  id                  :integer          not null, primary key
#  message             :text(65535)
#  sender_id           :integer
#  chat_direct_room_id :integer
#  created_at          :datetime         not null
#  updated_at          :datetime         not null
#
# Indexes
#
#  index_chat_direct_messages_on_chat_direct_room_id  (chat_direct_room_id)
#  index_chat_direct_messages_on_sender_id            (sender_id)
#

require 'rails_helper'

RSpec.describe ChatDirectMessage, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
