class CreateChatDirectWithAdminRooms < ActiveRecord::Migration
  def change
    create_table :chat_direct_with_admin_rooms do |t|
      t.integer :user_id, null: false
      t.integer :admin_id, null: false

      t.timestamps null: false
    end
    add_index :chat_direct_with_admin_rooms, :user_id
  end
end
