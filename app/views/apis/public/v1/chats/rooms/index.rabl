object false
if @chat_rooms.present?
  child(@chat_rooms, root: :rooms, object_root: false) do
    attributes :name, :chat_room_id, :chat_room_type, :last_sent_at, :last_sent_message
    node(:unread_count) { 0 }
  end
else
  node(:rooms) { [] }
end
