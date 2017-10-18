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
    if @relationship.save
      redirect_to "/friends"
    else
      redirect_to "/"
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
  def relationship_params
    params.require(:relationship).permit(:friend_id, :befriender_id, :status)
  end
end
