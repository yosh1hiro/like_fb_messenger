class CreateChatDirectMessages < ActiveRecord::Migration
  def change
    create_table :chat_direct_messages do |t|
      t.text :message, null: false
      t.integer :sender_id, null: false
      t.references :chat_direct_room, null: false, index: true, foreign_key: true

      t.timestamps null: false
    end
    add_index :chat_direct_messages, :sender_id
  end
end
