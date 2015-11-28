class CreateChatDirectUnreadCaches < ActiveRecord::Migration
  def change
    create_table :chat_direct_unread_caches do |t|
      t.references :chat_direct_room, null: false, index: true, foreign_key: true
      t.integer :recipient_id, null: false, index: true
      t.datetime :last_read_at, null: false
      t.integer :unread_count, null: false, default: 0

      t.timestamps null: false
    end
  end
end
