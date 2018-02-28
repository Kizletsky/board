class PostsController < ApplicationController

  before_action :set_post, only: [:show, :edit, :update, :destroy]

  def index
    @posts = Post.order("created_at DESC")
  end

  def show
    #set_post
  end

  def new
    @post = Post.new
  end

  def create
    @post = Post.new(post_params)
    if @post.save
      # redirect to created post and show flash
      redirect_to @post, notice: "Post successfully created !"
    else
      render :new
    end
  end

  def edit
    #set_post
  end

  def update
    #set_post
    if @post.update_attributes(post_params)
      redirect_to @post, notice: "Post successfully updated !"
    else
      render :edit
    end
  end

  def destroy
    #set_post
    @post.destroy
    redirect_to posts_path, notice: "Post successfully deleted !"
  end

  private

  def set_post
    @post = Post.find(params[:id])
  end

  def post_params
    params.require(:post).permit(:title, :body, :image, :image_cache)
  end

end
