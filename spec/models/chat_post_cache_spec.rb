# == Schema Information
#
# Table name: chat_post_caches
#
#  id                       :integer          not null, primary key
#  chat_room_index_cache_id :integer          not null
#  postable_id              :integer          not null
#  postable_type            :string(255)      not null
#  sender_id                :integer          not null
#  sender_type              :string(255)      not null
#  message                  :text(65535)
#  image                    :string(255)
#  stamp_id                 :integer
#  posted_at                :datetime         not null
#  created_at               :datetime         not null
#  updated_at               :datetime         not null
#
# Indexes
#
#  chat_post_caches_index  (chat_room_index_cache_id,postable_id,sender_id)
#

require 'rails_helper'

RSpec.describe ChatPostCache, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
