class CreateChatDirectWithAdminImages < ActiveRecord::Migration
  def change
    create_table :chat_direct_with_admin_images do |t|
      t.string :image, null: false
      t.references :chat_direct_with_admin_room, null: false, foreign_key: true

      t.timestamps null: false
    end
    add_index :chat_direct_with_admin_images, :chat_direct_with_admin_room_id, name: 'direct_with_admin_image'
  end
end
