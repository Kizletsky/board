class FavoritesController < ApplicationController
before_action :authenticate_user!
before_action :set_post

  def index
    
  end

  def create
    @fav_post = Favorite.create(post: @post, user: current_user)
  end

  def destroy
    Favorite.where(post: @post, user: current_user).first.destroy
  end

  private

  def set_post
    @post = Post.find(params[:id])
  end
end
