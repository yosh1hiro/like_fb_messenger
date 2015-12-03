object false

child(@chat_rooms, root: false, object_root: false) do
  extends 'public/v1/rooms/_attributes'

  child(:chat_room_members, root: :members, object_root: false) do
    attributes :member_id, :member_type, :last_name, :first_name, :image
  end
end
