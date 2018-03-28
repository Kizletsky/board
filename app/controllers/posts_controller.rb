# frozen_string_literal: true

class PostsController < ApplicationController
  before_action :set_post, only: %i[show edit update destroy]
  before_action :authenticate_user!, except: %i[index show]
  before_action :check_owner, only: %i[destroy edit update]

  def index
    @posts = Post.search(params[:keywords]).uniq
  end

  def show; end

  def edit; end

  def new
    @post = Post.new
  end

  def create
    @post = Post.new(post_params)
    # link the post to user that logged in atm
    @post.user = current_user
    if @post.save
      # redirect to created post and show flash
      redirect_to @post, success: 'Post successfully created !'
    else
      render :new
    end
  end

  def update
    if @post.update(post_params)
      # redirect to updated post and show flash
      redirect_to @post, success: 'Post successfully updated !'
    else
      render :edit
    end
  end

  def destroy
    @post.destroy
    # redirect to root and show flash
    redirect_to posts_path, success: 'Post successfully deleted !'
  end

  private

  def set_post
    @post = Post.find(params[:id])
  end

  def post_params
    params.require(:post).permit(:title, :body, :image, :image_cache, :status,
                                 :adress, :current_tags)
  end

  def check_owner
    # check if current user is owner of the post
    redirect_to @post, alert: 'You are not the owner of this post' unless
    current_user == @post.user || current_user.admin?
  end
end
