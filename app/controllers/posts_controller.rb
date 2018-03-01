class PostsController < ApplicationController

  before_action :set_post, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!, except: [:index, :show]
  before_action :is_owner, only: [:destroy, :edit, :update]


  def index
    @posts = Post.order("updated_at DESC")
  end

  def show
    #set_post
  end

  def new
    @post = Post.new
  end

  def create
    @post = Post.new(post_params)
    # link the post to user that logged in atm
    @post.user = current_user
    if @post.save
      # redirect to created post and show flash
      redirect_to @post, success: "Post successfully created !"
    else
      render :new
    end
  end

  def edit
    #set_post
    #is_owner
  end

  def update
    #set_post
    #is_owner
    if @post.update_attributes(post_params)
      # redirect to updated post and show flash
      redirect_to @post, success: "Post successfully updated !"
    else
      render :edit
    end
  end

  def destroy
    #set_post
    #is_owner
    @post.destroy
    # redirect to root and show flash
    redirect_to posts_path, success: "Post successfully deleted !"
  end

  private

    def set_post
      @post = Post.find(params[:id])
    end

    def post_params
      params.require(:post).permit(:title, :body, :image, :image_cache)
    end

    def is_owner
      #check if current user is owner of post
      if @post.user != current_user
        redirect_to @post, alert: "You are not the owner of this post"
      end
    end

end
