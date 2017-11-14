class ChatsController < ApplicationController
  before_action :authenticate_user!

  require "opentok"


  def index
    @relationship = Relationship.new
    @friends = current_user.accepted_friends
    @friend_requests = current_user.friend_requests
    gon.user_id = current_user.id
    @chats = current_user.chats
    @chat = Chat.new
  end

  def create
    opentok_config
    session = @opentok.create_session
    session_id = session.session_id
    @chat = Chat.new(name: chat_params[:name], session_id: session_id)
    if @chat.save
      @user_chat = UserChat.create(user_id: current_user.id, chat_id: @chat.id)
      redirect_back(fallback_location: '/chats')
    end
  end

  def show
    @current_chat = Chat.find(params[:id])
    opentok_config
    gon.session_id = @current_chat.session_id
    gon.token = @opentok.generate_token @current_chat.session_id
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
    redirect_back(fallback_location: '/chats')
  end

  private

  def opentok_config
    if @opentok.nil?
      @opentok = OpenTok::OpenTok.new ENV['API_KEY'], ENV['API_SECRET']
    end
  end

  def chat_params
    params.require(:chat).permit(:name, :session_id)
  end

  def config_opentok
    if @opentok.nil?
      @opentok = OpenTok::OpenTok.new ENV['API_KEY'], ENV['SECRET']
    end
  end

end
