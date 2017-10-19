class RelationshipsController < ApplicationController
  def index
    @friends = current_user.accepted_friends
    @friend_requests = Relationship.all.where(friend_id: current_user.id).where(status: "pending")
  end

  def new
      @relationship = Relationship.new
  end

  def create
    @relationship = Relationship.new(relationship_params)
    if friends_pending? || befrienders_pending?
      flash[:info] = "Friendship Pending"
      redirect_to '/friends/new'
    elsif friends_accepted? || befrienders_accepted?
      flash[:info] = "You are already friends with this person"
      redirect_to '/friends/new'
    elsif self_friend?
      flash[:info] = "You cannot be friends with yourself."
      redirect_to '/friends/new'
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

  def destroy
    @friend_request = Relationship.find(params[:id])
    @friend_request.destroy
    redirect_to "/friends"
  end

  def friend_decision
    @relationship = Relationship.find(params[:id])
    @relationship.update_attributes(status: "accepted")
    redirect_to "/friends"
  end

  private

  def self_friend?
    User.find(relationship_params[:friend_id]).id == current_user.id
  end

  def friends_pending?
    friends = current_user.friends.find_by(befriender_id: relationship_params[:friend_id])
    friends != nil && friends.status == "pending"
  end

  def friends_accepted?
    friends = current_user.friends.find_by(befriender_id: relationship_params[:friend_id])
    friends != nil && friends.status == "accepted"
  end

  def befrienders_pending?
    befrienders = current_user.befrienders.find_by(friend_id: relationship_params[:friend_id])
    befrienders != nil && befrienders.status == "pending"
  end

  def befrienders_accepted?
    befrienders = current_user.befrienders.find_by(friend_id: relationship_params[:friend_id])
    befrienders != nil && befrienders.status == "accepted"
  end

  def relationship_params
    params.require(:relationship).permit(:friend_id, :befriender_id, :status)
  end
end
