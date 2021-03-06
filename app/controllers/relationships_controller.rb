class RelationshipsController < ApplicationController
  before_action :authenticate_user!

  def create
    unless friend
      flash[:danger] = "User does not exist."
      render js: "location.reload()"
    else
      @relationship = Relationship.new(friend_id: friend.id, befriender_id: relationship_params[:befriender_id], status: relationship_params[:status])
      if friends_pending? || befrienders_pending?
        flash[:info] = "Friendship Pending"
        render js: "location.reload()"
      elsif friends_accepted? || befrienders_accepted?
        flash[:info] = "You are already friends with this person"
        render js: "location.reload()"
      elsif self_friend?
        flash[:info] = "You can't be friends with yourself!"
        render js: "location.reload()"
      else
        if @relationship.save
          gon.send_id = @relationship.friend_id
          ActionCable.server.broadcast "room_channel_user_#{gon.send_id}",
                                      friend_username: User.find(@relationship.befriender_id).username,
                                      friend_request_content: true

          head :ok
        end
      end
    end
  end

  def destroy
    @friend_request = Relationship.find(params[:id])
    @friend_request.destroy
    redirect_back(fallback_location: '/chats')
  end

  def delete_friend
    if Relationship.find_by(friend_id: params[:id]) && Relationship.find_by(befriender_id: current_user.id)
      @friend = Relationship.find_by(friend_id: params[:id])
      @friend.destroy
    elsif Relationship.find_by(befriender_id: params[:id]) && Relationship.find_by(friend_id: current_user.id)
      @friend = Relationship.find_by(befriender: params[:id])
      @friend.destroy
    end
    redirect_back(fallback_location: '/chats')
  end

  def friend_decision
    @relationship = Relationship.find(params[:id])
    @relationship.update_attributes(status: "accepted")
    redirect_back(fallback_location: '/chats')
  end

  private

  def friend
    User.find_by(username: relationship_params[:friend_id])
  end

  def self_friend?
    friend.id == current_user.id
  end

  def friends_pending?
    friends = current_user.friends.find_by(befriender_id: friend.id)
    friends != nil && friends.status == "pending"
  end

  def friends_accepted?
    friends = current_user.friends.find_by(befriender_id: friend.id)
    friends != nil && friends.status == "accepted"
  end

  def befrienders_pending?
    befrienders = current_user.befrienders.find_by(friend_id: friend.id)
    befrienders != nil && befrienders.status == "pending"
  end

  def befrienders_accepted?
    befrienders = current_user.befrienders.find_by(friend_id: friend.id)
    befrienders != nil && befrienders.status == "accepted"
  end

  def relationship_params
    params.require(:relationship).permit(:friend_id, :befriender_id, :status)
  end
end
