class CreateChatRoomIndexCaches < ActiveRecord::Migration
  def change
    create_table :chat_room_index_caches do |t|
      t.string :name, null: false
      t.integer :chat_room_id, null: false
      t.string :chat_room_type, null: false
      t.datetime :last_sent_at, default: Time.now
      t.text :last_sent_message

      t.timestamps null: false
    end
    add_index :chat_room_index_caches, :chat_room_id, name: 'chattable_id'
    add_index :chat_room_index_caches, :chat_room_type, name: 'chattable_type'
  end
end
