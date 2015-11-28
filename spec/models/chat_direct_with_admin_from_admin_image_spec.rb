# == Schema Information
#
# Table name: chat_direct_with_admin_from_admin_images
#
#  id                             :integer          not null, primary key
#  image                          :string(255)      not null
#  chat_direct_with_admin_room_id :integer          not null
#  created_at                     :datetime         not null
#  updated_at                     :datetime         not null
#
# Indexes
#
#  direct_with_admin_from_admin_image  (chat_direct_with_admin_room_id)
#

require 'rails_helper'

RSpec.describe ChatDirectWithAdminFromAdminImage, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
