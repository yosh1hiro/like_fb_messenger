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

require 'rails_helper'

RSpec.describe ChatDirectWithAdminRoom, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
