class ChatsController < ApplicationController
  before_action :authenticate_user!

  def index
    @relationship = Relationship.new
    @friends = current_user.accepted_friends
    @friend_requests = current_user.friend_requests
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
    @relationship = Relationship.new
    @friends = current_user.accepted_friends
    @friend_requests = current_user.friend_requests
    gon.user_id = current_user.id
    @chats = current_user.chats
    @chat = Chat.new
    if !current_user.chats.where("chat_id = #{params[:id]}").empty?
      @user_chat = UserChat.new()
      gon.user_id = current_user.id
      @chat = Chat.find(params[:id])
      @chat_messages = Chat.find(params[:id]).chat_messages
      @chat_message = ChatMessage.new
      gon.chat_id = @chat.id
    else
      redirect_to "/chats"
    end
  end

  def destroy
    chat = Chat.find(params[:id])
    chat_users = UserChat.where(chat_id: chat.id)
    chat.destroy
    chat_users.destroy_all
    redirect_to "/chats"
  end

  private

  def chat_params
    params.require(:chat).permit(:name)
  end
end
