class UserChatsController < ApplicationController
  def create
    @user_chat = UserChat.new(user_id: User.find_by(username: user_chats_params[:user_id]).id, chat_id: user_chats_params[:chat_id])
      if @user_chat.save
        redirect_to '/chats'
      end
  end

  private

  def user_chats_params
    params.require(:user_chat).permit(:user_id, :chat_id)
  end

end
