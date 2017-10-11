class ChatMessagesController < ApplicationController
  before_action :authenticate_user!, only: [:create, :update]


  def create
    @chat_message = ChatMessage.new(message_params)
    if @chat_message.save
      ActionCable.server.broadcast "room_channel_#{message_params[:chat_id]}",
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
