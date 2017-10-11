class AddChatIdToChatMessages < ActiveRecord::Migration[5.1]
  def change
    add_column :chat_messages, :chat_id, :integer
  end
end
