# == Schema Information
#
# Table name: chat_post_caches
#
#  id                       :integer          not null, primary key
#  chat_room_index_cache_id :integer
#  postable_id              :integer
#  postable_type            :string(255)
#  sender_id                :integer
#  sender_type              :string(255)
#  message                  :text(65535)
#  image                    :string(255)
#  stamp_id                 :integer
#  posted_at                :datetime
#  created_at               :datetime         not null
#  updated_at               :datetime         not null
#  chat_room_id             :integer
#  chat_room_type           :string(255)
#
# Indexes
#
#  chat_post_caches_index  (chat_room_index_cache_id,postable_id,sender_id)
#

class ChatPostCache < ActiveRecord::Base
  paginates_per 10
  attr_accessor :sender

  belongs_to :chat_room_index_cache
  belongs_to :postable, polymorphic: true
  belongs_to :chat_room, polymorphic: true

  mount_uploader :image, ImageUploader
end
