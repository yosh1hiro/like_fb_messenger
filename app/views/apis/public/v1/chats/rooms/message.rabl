object false
child(@chat_post, root: "chat_message") do
  attributes :id, :postable_type, :message, :stamp_id, :image, :stamp_image, :posted_at
  child(:sender) do
    attributes :id, :last_name, :first_name, :image
  end
end
