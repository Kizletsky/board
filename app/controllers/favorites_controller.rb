# frozen_string_literal: true

class FavoritesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_post, except: :index

  def index
    @favorites = current_user.favorite_posts
    @favorites.each { |fav| truncate_body(fav) }
    render json: @favorites
  end

  def create
    fav = Favorite.where(user: current_user, post: @post)
    Favorite.create(post: @post, user: current_user) if fav.blank?
    truncate_body(@post)
    render json: @post
  end

  def destroy
    Favorite.where(post: @post, user: current_user).first.destroy
    render json: @post
  end

  private

  def truncate_body(post)
    post.body = post.body.truncate(40, separator: ' ')
  end

  def set_post
    @post = Post.find(params[:id])
  end
end
