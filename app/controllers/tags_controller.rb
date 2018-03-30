# frozen_string_literal: true

class TagsController < ApplicationController
  def show
    @tag = Tag.find_by(name: params[:id])
  end

  def create
    @tag = Tag.new(tag_params)
    if @tag.save
      render json: @tag
    else
      render json: { errors: @tag.errors.full_messages }, status:
                                                          :unprocessable_entity
    end
  end

  private

  def tag_params
    params.permit(:name)
  end
end
