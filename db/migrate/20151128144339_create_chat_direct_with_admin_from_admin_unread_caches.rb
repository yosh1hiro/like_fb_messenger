class CreateChatDirectWithAdminFromAdminUnreadCaches < ActiveRecord::Migration
  def change
    create_table :chat_direct_with_admin_from_admin_unread_caches do |t|
      t.references :chat_direct_with_admin_room, null: false, foreign_key: true
      t.integer :recipient_id, null: false
      t.datetime :last_read_at, null: false
      t.integer :unread_count, null: false, default: 0

      t.timestamps null: false
    end
    add_index :chat_direct_with_admin_from_admin_unread_caches, :chat_direct_with_admin_room_id, name: 'chat_direct_with_admin_room_index'
    add_index :chat_direct_with_admin_from_admin_unread_caches, :recipient_id, name: 'chat_direct_with_admin_unread_recipient'
  end
end
