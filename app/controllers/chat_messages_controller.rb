class ChatMessagesController < ApplicationController
  before_action :authenticate_user!, only: [:create, :update]


  def create
    gon.user_id = current_user.id
    @chat_message = ChatMessage.new(message_params)
    if @chat_message.save
      gon.chat = @chat_message.chat_id
      ActionCable.server.broadcast "room_channel_#{gon.chat}",
                                  content:  @chat_message.content,
                                  username: @chat_message.user.username
      head :ok
    end
  end

private

  def message_params
    params.require(:chat_message).permit(:user_id, :content, :chat_id)
  end
end
