class CommentsController < ApplicationController
  before_action :authenticate_user!, only: [:create, :update]

  def create
    @comment = Comment.new(allowed_params_comment)
    if @comment.save
      redirect_to "/post/#{allowed_params_comment[:post_id]}"
    else
      @comment.errors.full_messages.each do |error|
        flash[:danger] = "#{error}"
      end
      redirect_to "/post/#{allowed_params_comment[:post_id]}"
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

  def allowed_params_comment
    params.require(:comment).permit(:user_id, :post_id, :content)
  end

end
