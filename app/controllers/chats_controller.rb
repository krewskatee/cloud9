class ChatsController < ApplicationController

  def index
    @chats = Chat.all
    @chat = Chat.new
  end

  def create
    @chat = Chat.new(chat_params)
    if @chat.save
      redirect_to '/chats'
    end
  end

  def show
    @chat = Chat.find(params[:id])
    @chat_messages = Chat.find(params[:id]).chat_messages
    @chat_message = ChatMessage.new
    gon.chat_id = @chat.id
  end

  private

  def chat_params
    params.require(:chat).permit(:user_id, :name)
  end
end
