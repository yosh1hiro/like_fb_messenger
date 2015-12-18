object false

child(@chat_room, root: :chat_room) do
  extends 'public/v1/rooms/_attributes'
  child(@members, root: :members, object_root: false) do
    extends 'public/v1/members/_attributes'
  end
  if @chat_posts.present?
    child(@chat_posts, root: :posts, object_root: false) do
      attributes :postable_id, :postable_type, :message, :stamp_id, :image, :stamp_image, :posted_at, :sender_type, :sender_id

      child(:sender, root: :sender) do
        extends 'public/v1/members/_attributes'
      end
    end
  else
    node(:posts) { [] }
  end
  node(:current_page) { @page }
  node(:next_page) { @next_page }
  node(:end_flag) { @end_flag }
end
