object false
child(@chat_post, root: :chat_post) do |p|
  attributes :id, :postable_type, :message, :stamp_id, :image, :stamp_image, :created_at, :chat_room_id, :chat_room_type, :posted_at
  child(:sender, root: :sender) do
    extends 'public/v1/members/_attributes'
  end
end
