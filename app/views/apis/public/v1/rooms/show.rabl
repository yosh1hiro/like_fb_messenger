object false

child(@chat_room) do
  extends 'v1/rooms/_attributes'
  extends 'v1/members'
  node(:current_page) { @page.to_i }
  node(:next_page) { @page.to_i + 1 }

  child(@chat_posts, root: :messages, object_root: false) do
   attributes :id, :postable_type, :message, :stamp_id, :image, :stamp_image, :posted_at

    child(:sender) do
      attributes :id, :last_name, :first_name, :image
    end
  end
end
