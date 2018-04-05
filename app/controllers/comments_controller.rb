# frozen_string_literal: true

class CommentsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_post
  before_action :set_comment, only: %i[destroy update edit]

  def new
    @comment = @post.comments.new
    render json: @comment
  end

  def create
    @comment = @post.comments.new(comment_params)
    @comment.user = current_user
    if @comment.save
      broadcast_comment
    else
      render json: { errors: @comment.errors.full_messages }, status:
      :unprocessable_entity
    end
  end

  def edit
    render json: @comment
  end

  def update
    if @comment.update(comment_params)
      broadcast_comment
    else
      render json: { errors: @comment.errors.full_messages }, status:
      :unprocessable_entity
    end
  end

  def destroy
    @comment.destroy
    broadcast_comment
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

  def broadcast_comment
    ActionCable.server.broadcast "comments:#{@post.id}", comment_data
  end

  def access?
    current_user == @comment.user || current_user.admin?
  end

  def comment_data
    { comment: @comment,
      author: { id: @comment.user.id,
                name: @comment.user.username,
                avatar: @comment.user.avatar.url(:user_thumb) },
      access: access?,
      action: action_name }
  end
end
