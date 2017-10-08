class ChatMessagesController < ApplicationController
  before_action :authenticate_user!, only: [:create, :update]

  def index
    @chat_messages = ChatMessage.all
    @chat_message = ChatMessage.new
  end

  def create
    @chat_message = ChatMessage.new(message_params)
    if @chat_message.save
      ActionCable.server.broadcast 'room_channel',
                                  content:  @chat_message.content,
                                  username: @chat_message.user.username
      head :ok
    end
  end

  def message_params
    params.require(:chat_message).permit(:user_id, :content)
  end
end
