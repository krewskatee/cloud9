class ChangeSessionIdFromChats < ActiveRecord::Migration[5.1]
  def change
    change_column :chats, :session_id, :string
  end
end
