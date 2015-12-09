object false

child(@chat_room, root: :chat_room) do
  extends 'public/v1/rooms/_attributes'

  child(@chat_posts, root: :posts, object_root: false) do
   attributes :id, :postable_type, :message, :stamp_id, :image, :stamp_image, :posted_at

    child(:sender) do
      extends 'public/v1/members/_attributes'
    end
  end
  node(:posts) { [] }
end
