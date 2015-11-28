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

require 'rails_helper'

RSpec.describe ChatDirectUnreadCache, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
