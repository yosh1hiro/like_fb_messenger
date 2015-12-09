# == Schema Information
#
# Table name: chat_room_index_caches
#
#  id                :integer          not null, primary key
#  name              :string(255)      not null
#  chat_room_id      :integer          not null
#  chat_room_type    :string(255)      not null
#  last_sent_at      :datetime         default(Wed, 09 Dec 2015 03:00:29 UTC +00:00)
#  last_sent_message :text(65535)
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#  target_type       :string(255)
#
# Indexes
#
#  chattable_id    (chat_room_id)
#  chattable_type  (chat_room_type)
#

require 'rails_helper'

RSpec.describe ChatRoomIndexCache, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
