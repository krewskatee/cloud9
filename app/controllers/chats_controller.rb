class ChatsController < ApplicationController

  def index
    @friends = Relationship.all.where(befriender_id: current_user.id).where(status: "accepted") && Relationship.all.where(friend_id: current_user.id).where(status: "accepted")
    @friend_requests = Relationship.all.where(friend_id: current_user.id).where(status: "pending")
    gon.user_id = current_user.id
    @chats = current_user.chats
    @chat = Chat.new
  end

  def create
    @chat = Chat.new(chat_params)
    if @chat.save
      @user_chat = UserChat.create(user_id: current_user.id, chat_id: @chat.id)
      redirect_to '/chats'
    end
  end

  def show
    @user_chat = UserChat.new()
    gon.user_id = current_user.id
    @chat = Chat.find(params[:id])
    @chat_messages = Chat.find(params[:id]).chat_messages
    @chat_message = ChatMessage.new
    gon.chat_id = @chat.id
  end

  private

  def chat_params
    params.require(:chat).permit(:name)
  end
end
