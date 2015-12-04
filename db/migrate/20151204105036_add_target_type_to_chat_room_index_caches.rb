class AddTargetTypeToChatRoomIndexCaches < ActiveRecord::Migration
  def change
    add_column :chat_room_index_caches, :target_type, :string
  end
end
