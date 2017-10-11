class ChangeUserIdFromChatsToInteger < ActiveRecord::Migration[5.1]
  def change
     remove_column :chats, :user_id
     add_column :chats, :user_id, :integer
  end
end
