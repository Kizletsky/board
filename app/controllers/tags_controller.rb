class TagsController < ApplicationController
  def show
    @tag = Tag.find_by(tag_params)
    @posts = @tag.posts
  end

  def create
    @tag = Tag.new(tag_params)
    respond_to do |format|
    @tag.save
        format.json { render json: @tag }
    end
  end

  private

  def tag_params
    params.permit(:name)
  end



end
