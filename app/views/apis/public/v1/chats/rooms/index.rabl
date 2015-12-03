object false

child(@chat_room, root: false, object_root: false) do
  extends 'v1/chats/rooms/_attributes'

  child(:chat_room_members, root: :members, object_root: false) do
    attributes :member_id, :member_type, :last_name, :first_name, :image
  end
end
