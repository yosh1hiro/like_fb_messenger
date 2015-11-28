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

FactoryGirl.define do
  factory :chat_direct_with_admin_from_admin_unread_cach, :class => 'ChatDirectWithAdminFromAdminUnreadCache' do
    chat_direct_with_admin_room nil
recipient_id 1
last_read_at "2015-11-28 23:43:39"
unread_count 1
  end

end
