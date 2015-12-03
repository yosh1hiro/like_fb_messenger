# == Schema Information
#
# Table name: chat_room_index_caches
#
#  id                :integer          not null, primary key
#  name              :string(255)      not null
#  chat_room_id      :integer          not null
#  chat_room_type    :string(255)      not null
#  last_sent_at      :datetime         default(Thu, 03 Dec 2015 17:19:38 UTC +00:00)
#  last_sent_message :text(65535)
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#
# Indexes
#
#  chattable_id    (chat_room_id)
#  chattable_type  (chat_room_type)
#

FactoryGirl.define do
  factory :chat_room_index_cach, :class => 'ChatRoomIndexCache' do
    name "MyString"
chat_room_id 1
chat_room_type "MyString"
last_sent_at "2015-12-03 13:55:11"
last_sent_message "MyText"
  end

end
