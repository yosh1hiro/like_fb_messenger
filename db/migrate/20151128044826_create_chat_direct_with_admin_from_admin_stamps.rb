class CreateChatDirectWithAdminFromAdminStamps < ActiveRecord::Migration
  def change
    create_table :chat_direct_with_admin_from_admin_stamps do |t|
      t.integer :stamp_id, null: false
      t.references :chat_direct_with_admin_room, null: false, foreign_key: true

      t.timestamps null: false
    end
    add_index :chat_direct_with_admin_from_admin_stamps, :chat_direct_with_admin_room_id, name: 'direct_with_admin_from_admin_stamp'
  end
end
