class Api::V1::PostsController < ApplicationController

  def index
    @posts = Post.all.includes(:comments).order("created_at desc")
    search_attribute = params[:search]
    if search_attribute
      @posts = Post.search_for(params[:search])
    end
  end

  def show
    @comment = Comment.new
    @post = Post.find(params[:id])
    gon.post_id = @post.id
    gon.current_user_id = current_user.id
    @comments = @post.comments.order("created_at")
  end
end
