object false
child(@chat_post, root: :chat_post) do |p|
  attributes :id, :postable_type, :message, :stamp_id, :image, :stamp_image, :created_at
  node(:chat_room_id) { p.chat_direct_room_id }
  node(:posted_at) { p.created_at }
  child(:sender, root: :sender) do
    extends 'public/v1/members/_attributes'
  end
end
