class CreateChatDirectWithAdminFromAdminMessages < ActiveRecord::Migration
  def change
    create_table :chat_direct_with_admin_from_admin_messages do |t|
      t.text :message, null: false
      t.references :chat_direct_with_admin_room, null: false, foreign_key: true

      t.timestamps null: false
    end
    add_index :chat_direct_with_admin_from_admin_messages, :chat_direct_with_admin_room_id, name: 'direct_admin_message_from_admin'
  end
end
