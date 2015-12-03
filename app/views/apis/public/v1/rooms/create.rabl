object false

child(@chat_room) do
  extends 'public/v1/rooms/_attributes'
  extends 'public/v1/members/_attributes'

  child(@chat_posts, root: :messages, object_root: false) do
   attributes :id, :postable_type, :message, :stamp_id, :image, :stamp_image, :posted_at

    child(:sender) do
      attributes :id, :last_name, :first_name, :image
    end
  end
end
