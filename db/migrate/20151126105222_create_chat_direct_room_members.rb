class CreateChatDirectRoomMembers < ActiveRecord::Migration
  def change
    create_table :chat_direct_room_members do |t|
      t.integer :my_user_id, null: false
      t.integer :target_user_id, null: false
      t.references :chat_direct_room, null: false, index: true, foreign_key: true

      t.timestamps null: false
    end
    add_index :chat_direct_room_members, :my_user_id
  end
end
