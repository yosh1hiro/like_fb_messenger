class DropNotNullRestrictionFromChatPostCache < ActiveRecord::Migration
  def up
    change_column :chat_post_caches, :chat_room_index_cache_id, :integer, null: true
    change_column :chat_post_caches, :postable_id, :integer, null: true
    change_column :chat_post_caches, :postable_type, :string, null: true
    change_column :chat_post_caches, :sender_id, :integer, null: true
    change_column :chat_post_caches, :sender_type, :string, null: true
    change_column :chat_post_caches, :posted_at, :datetime, null: true
  end

  def down
    change_column :chat_post_caches, :chat_room_index_cache_id, :integer, null: false
    change_column :chat_post_caches, :postable_id, :integer, null: false
    change_column :chat_post_caches, :postable_type, :string, null: false
    change_column :chat_post_caches, :sender_id, :integer, null: false
    change_column :chat_post_caches, :sender_type, :string, null: false
    change_column :chat_post_caches, :posted_at, :datetime, null: false
  end
end
