object false

child(@chat_room, root: :chat_room) do
  extends 'public/v1/rooms/_attributes'

  if @chat_posts.present?
    child(@chat_posts, root: :posts, object_root: false) do
      attributes :id, :postable_type, :message, :stamp_id, :image, :stamp_image, :posted_at

      child(:sender) do
        extends 'public/v1/members/_attributes'
      end
    end
  else
    node(:posts) { [] }
  end

  if @members.present?
    child(@members, root: :members, object_root: false) do
      extends 'public/v1/members/_attributes'
    end
  else
    node(:members) { [] }
  end
end
