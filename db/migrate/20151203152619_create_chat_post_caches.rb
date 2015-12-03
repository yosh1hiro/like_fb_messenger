class CreateChatPostCaches < ActiveRecord::Migration
  def change
    create_table :chat_post_caches do |t|
      t.integer :chat_room_index_cache_id, null: false
      t.integer :postable_id, null: false
      t.string :postable_type, null: false
      t.integer :sender_id, null: false
      t.string :sender_type, null: false
      t.text :message
      t.string :image
      t.integer :stamp_id
      t.datetime :posted_at, null: false

      t.timestamps null: false
    end
    add_index :chat_post_caches, [:chat_room_index_cache_id, :postable_id, :sender_id], name: 'chat_post_caches_index'
  end
end
