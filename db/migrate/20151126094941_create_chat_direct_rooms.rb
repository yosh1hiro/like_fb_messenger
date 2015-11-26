class CreateChatDirectRooms < ActiveRecord::Migration
  def change
    create_table :chat_direct_rooms do |t|

      t.timestamps null: false
    end
  end
end
