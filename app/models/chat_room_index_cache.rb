# == Schema Information
#
# Table name: chat_room_index_caches
#
#  id                :integer          not null, primary key
#  name              :string(255)      not null
#  chat_room_id      :integer          not null
#  chat_room_type    :string(255)      not null
#  last_sent_at      :datetime         default(Thu, 03 Dec 2015 17:19:38 UTC +00:00)
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

class ChatRoomIndexCache < ActiveRecord::Base
  attr_accessor :room_name, :room_image

  belongs_to :chat_room, polymorphic: true
  has_many :chat_post_caches
  has_many :chat_direct_room_members, foreign_key: :chat_direct_room_id, primary_key: :chat_room_id

  def name
    case chat_room_type
    when 'ChatDirectRoom'
      room_name
    else
      [:name]
    end
  end

  def image
    case chat_room_type
    when 'ChatDirectRoom'
      room_image
    else
      [:name]
    end
  end
end
