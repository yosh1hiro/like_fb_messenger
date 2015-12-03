# == Schema Information
#
# Table name: chat_direct_images
#
#  id                  :integer          not null, primary key
#  image               :string(255)      not null
#  sender_id           :integer          not null
#  chat_direct_room_id :integer          not null
#  created_at          :datetime         not null
#  updated_at          :datetime         not null
#
# Indexes
#
#  index_chat_direct_images_on_chat_direct_room_id  (chat_direct_room_id)
#

FactoryGirl.define do
  factory :chat_direct_image do
    image "MyString"
sender_id 1
chat_direct_room nil
  end

end
