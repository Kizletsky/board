class CommentsController < ApplicationController

  before_action :authenticate_user!
  before_action :set_post

  def new
    respond_to do |format|
      format.js
    end
  end

  def create
    @comment = @post.comments.new(comment_params)
    @comment.user = current_user

    respond_to do |format|
      if @comment.save
        format.js
      else
        
      end
    end
  end

  private
  def comment_params
    params.require(:comment).permit(:body)
  end

  def set_post
    @post = Post.find(params[:post_id])
  end
end
