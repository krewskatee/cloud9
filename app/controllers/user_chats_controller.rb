class UserChatsController < ApplicationController
  before_action :authenticate_user!, only: [:create]
  
  def create
      user = User.find_by(username: user_chats_params[:user_id])
      @user_chat = UserChat.new(user_id: user.id, chat_id: user_chats_params[:chat_id])
      if @user_chat.save
        redirect_to '/chats'
      else
        flash[:warning] = "#{user.username} is already in this chatroom."
        redirect_to "/chats/#{user_chats_params[:chat_id]}"
      end
  end

  private

  def user_chats_params
    params.require(:user_chat).permit(:user_id, :chat_id)
  end

end
