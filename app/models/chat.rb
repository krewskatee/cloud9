class Chat < ApplicationRecord
  has_many :chat_messages
  
  has_many :user_chats
  has_many :users, through: :user_chats
end
