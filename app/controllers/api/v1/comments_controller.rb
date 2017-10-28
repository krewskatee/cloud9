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
      @post_id = @comment.post.id
      if @comment.save
        render json: {}, status: 200
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
      comment.destroy
    end

end
