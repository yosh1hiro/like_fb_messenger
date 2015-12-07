object false
child(@chat_post, root: :chat_post) do
  attributes :id, :postable_type, :message, :stamp_id, :image, :stamp_image, :posted_at
  child(:sender, root: :sender) do
    attributes :id, :last_name, :first_name, :image
  end
end
