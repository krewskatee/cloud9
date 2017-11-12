class AddSessionIdToChats < ActiveRecord::Migration[5.1]
  def change
    add_column :chats, :session_id, :integer
  end
end
