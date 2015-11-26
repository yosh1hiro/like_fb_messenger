# == Schema Information
#
# Table name: chat_direct_room_members
#
#  id                  :integer          not null, primary key
#  my_user_id          :integer          not null
#  target_user_id      :integer          not null
#  chat_direct_room_id :integer          not null
#  created_at          :datetime         not null
#  updated_at          :datetime         not null
#
# Indexes
#
#  index_chat_direct_room_members_on_chat_direct_room_id  (chat_direct_room_id)
#  index_chat_direct_room_members_on_my_user_id           (my_user_id)
#

require 'rails_helper'

RSpec.describe ChatDirectRoomMember, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
