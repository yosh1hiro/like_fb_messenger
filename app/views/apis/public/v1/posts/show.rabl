object false
child(@chat_post, root: :chat_post) do
  attributes :id, :postable_type, :message, :stamp_id, :image, :stamp_image, :posted_at
  child(:sender, root: :sender) do
    extends 'public/v1/members/_attributes'
  end
end
