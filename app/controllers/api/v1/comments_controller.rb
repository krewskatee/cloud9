class Api::V1::CommentsController < ApplicationController

    def show
      @comment = Comment.find(params[:id])
    end

    def index
      @comments = Comment.all
    end

    def create
      @comment = Comment.new(content: params[:content], post_id: params[:post_id], user_id: params[:user_id])
      if @comment.save
        render :show
      else
        render json: { errors: @comment.errors.full_messages }, status: 422
      end
    end

    def update
      @comment = Comment.find(params[:id])
      @comment.update_attributes(content: params[:content])
      @post = @comment.post
      @post_id = @comment.post.id
      @post_comments = @post.comments.sort_by(&:created_at)
      if @comment.save
        render 'post_comments.json.jbuilder'
      else
        render json: { errors: @comment.errors.full_messages }, status: 422
      end
    end

    def edit
      @comment = Comment.find(params[:id])
      render 'edit.html.erb'
    end

    def destroy
      comment = Comment.find(params[:id])
      post_id = comment.post.id
      @post = comment.post
      @post_comments = @post.comments.sort_by(&:created_at)
      comment.destroy
      render 'post_comments.json.jbuilder'
    end

end
