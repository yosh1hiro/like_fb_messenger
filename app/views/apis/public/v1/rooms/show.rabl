object false

child(@chat_room, root: :chat_room) do
  extends 'public/v1/rooms/_attributes'
  child(@members, root: :members, object_root: false) do
    extends 'public/v1/members/_attributes'
  end
  child(@chat_posts, root: :messages, object_root: false) do
    attributes :id, :postable_type, :message, :stamp_id, :image, :stamp_image, :posted_at, :sender_type, :sender_id

    child(:sender, root: :sender) do
      attributes :id, :last_name, :first_name, :image
    end
  end
  node(:current_page) { @page.to_i }
  node(:next_page) { @page.to_i + 1 }
end
