class FavoritesController < ApplicationController
before_action :authenticate_user!
before_action :set_post, except: :index

  def index
    @favorites = current_user.favorite_posts
  end

  def create
    fav = Favorite.where(user: current_user, post: @post)
    Favorite.create(post: @post, user: current_user) if fav.blank? 
  end

  def destroy
    Favorite.where(post: @post, user: current_user).first.destroy
  end

  private

  def set_post
    @post = Post.find(params[:id])
  end
end
