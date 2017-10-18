class RelationshipsController < ApplicationController
  def index
    @friends = Relationship.all.where(befriender_id: current_user.id).where(status: "accepted") && Relationship.all.where(friend_id: current_user.id).where(status: "accepted")
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
        redirect_to "/friends"
      else
        redirect_to "/"
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
    if User.find(relationship_params[:friend_id]).id == current_user.id
      return true
    else
      return false
    end
  end

  def friends_pending?
    friends = current_user.friends.find_by(befriender_id: relationship_params[:friend_id])
    if friends != nil && friends.status == "pending"
      return true
    else
      return false
    end
  end

  def friends_accepted?
    friends = current_user.friends.find_by(befriender_id: relationship_params[:friend_id])
    if friends != nil && friends.status == "accepted"
      return true
    else
      return false
    end
  end

  def befrienders_pending?
    befrienders = current_user.befrienders.find_by(friend_id: relationship_params[:friend_id])
    if befrienders != nil && befrienders.status == "pending"
      return true
    else
      return false
    end
  end

  def befrienders_accepted?
    befrienders = current_user.befrienders.find_by(friend_id: relationship_params[:friend_id])
    if befrienders != nil && befrienders.status == "accepted"
      return true
    else
      return false
    end
  end

  def relationship_params
    params.require(:relationship).permit(:friend_id, :befriender_id, :status)
  end
end
