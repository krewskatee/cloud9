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

    def edit
      @comment = Comment.find(params[:id])
      render 'edit.html.erb'
    end

    def update
      @comment = Comment.find(params[:id])
      @comment.update_attributes(content: allowed_params_comment[:content])
      @post_id = @comment.post.id
      if @comment.save
        redirect_to "/post/#{@post_id}"
      else
        @comment.errors.full_messages.each do |error|
          flash[:danger] = "#{error}"
          redirect_to "/comment/#{@comment.id}/edit"
        end
      end
    end

    def destroy
      comment = Comment.find(params[:id])
      post_id = comment.post.id
      comment.destroy
      redirect_to("/post/#{post_id}")
    end

    private

    def allowed_params_comment
      params.require(:comment).permit(:user_id, :post_id, :content)
    end


end
