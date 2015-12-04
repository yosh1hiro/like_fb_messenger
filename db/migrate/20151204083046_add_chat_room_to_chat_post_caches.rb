class AddChatRoomToChatPostCaches < ActiveRecord::Migration
  def change
    change_table :chat_post_caches do |t|
      t.references :chat_room, :polymorphic => true
    end
  end
end
