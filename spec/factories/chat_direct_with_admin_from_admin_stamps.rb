# == Schema Information
#
# Table name: chat_direct_with_admin_from_admin_stamps
#
#  id                             :integer          not null, primary key
#  stamp_id                       :integer          not null
#  chat_direct_with_admin_room_id :integer          not null
#  created_at                     :datetime         not null
#  updated_at                     :datetime         not null
#
# Indexes
#
#  direct_with_admin_from_admin_stamp  (chat_direct_with_admin_room_id)
#

FactoryGirl.define do
  factory :chat_direct_with_admin_from_admin_stamp do
    stamp_id 1
    chat_direct_with_admin_room nil
  end

end
