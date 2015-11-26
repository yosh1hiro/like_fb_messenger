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

FactoryGirl.define do
  factory :chat_direct_message do
    message "MyText"
sender_id 1
chat_direct_room nil
  end

end
