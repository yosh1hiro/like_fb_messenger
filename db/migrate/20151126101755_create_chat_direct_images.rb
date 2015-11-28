class CreateChatDirectImages < ActiveRecord::Migration
  def change
    create_table :chat_direct_images do |t|
      t.string :image, null: false
      t.integer :sender_id, null: false
      t.references :chat_direct_room, null: false, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
