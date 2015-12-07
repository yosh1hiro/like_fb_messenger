object false

if @chat_rooms.present?
  child(@chat_rooms, root: :chat_rooms, object_root: false) do
    extends 'public/v1/rooms/_attributes'
  end
else
  node(:chat_rooms) { [] }
end
node(:current_page) { @page }
node(:next_page) { @next_page }
node(:end_flag) { @end_flag }
