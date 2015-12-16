# == Schema Information
#
# Table name: chat_direct_with_admin_rooms
#
#  id         :integer          not null, primary key
#  user_id    :integer          not null
#  admin_id   :integer          not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Indexes
#
#  index_chat_direct_with_admin_rooms_on_user_id  (user_id)
#

FactoryGirl.define do
  factory :chat_direct_with_admin_room do
    user_id 1
    admin_id 1
  end
end
