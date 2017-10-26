class Api::V1::PostsController < ApplicationController

  def show
    @comment = Comment.new
    @post = Post.find(params[:id])
    gon.post_id = @post.id
    gon.current_user_id = current_user.id
    @comments = @post.comments.order("created_at")
  end
end
