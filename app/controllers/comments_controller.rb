class CommentsController < ApplicationController

  before_action :authenticate_user!
  before_action :set_post
  before_action :set_comment, only: [:destroy, :update, :edit]


  def new
    @comment = @post.comments.new
  end

  def create
    @comment = @post.comments.new(comment_params)
    @comment.user = current_user
    respond_to do |format|
      if @comment.save
        format.js
      else
        format.js { render action: "new" }
      end
    end
  end

  def edit
    respond_to do |format|
      format.js { render action: "new" }
    end
  end

  def update
    respond_to do |format|
      if @comment.update_attributes(comment_params)
        format.js
      else
        format.js { render action: "new" }
      end
    end
  end

  def destroy
    @comment.destroy
  end

  private

  def comment_params
    params.require(:comment).permit(:body)
  end

  def set_post
    @post = Post.find(params[:post_id])
  end

  def set_comment
    @comment = @post.comments.find(params[:id])
  end
end
