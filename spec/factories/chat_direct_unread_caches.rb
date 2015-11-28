# == Schema Information
#
# Table name: chat_direct_unread_caches
#
#  id                  :integer          not null, primary key
#  chat_direct_room_id :integer          not null
#  recipient_id        :integer          not null
#  last_read_at        :datetime         not null
#  unread_count        :integer          default(0), not null
#  created_at          :datetime         not null
#  updated_at          :datetime         not null
#
# Indexes
#
#  index_chat_direct_unread_caches_on_chat_direct_room_id  (chat_direct_room_id)
#  index_chat_direct_unread_caches_on_recipient_id         (recipient_id)
#

FactoryGirl.define do
  factory :chat_direct_unread_cach, :class => 'ChatDirectUnreadCache' do
    chat_room nil
recipient_id 1
last_read_at "2015-11-28 23:33:25"
unread_count 1
  end

end
