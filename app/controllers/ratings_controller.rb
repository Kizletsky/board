# frozen_string_literal: true

class RatingsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_profile

  def index
    if @profile != current_user
      @rating = @profile.ratings.find_by(author_id: current_user.id)
      @state = @rating.blank? ? 'form' : 'rating'
      render json: { rating: @rating, state: @state, user_id: @profile.id }
    else
      render json: { state: '' }
    end
  end

  def create
    @rating = @profile.ratings.new(rating_params)
    @rating.author = current_user
    @rating.save
    @average = @profile.calculate_average
    render json: { rating: @rating, user_id: @profile.id, average: @average }
  end

  def destroy
    @profile.ratings.find(params[:id]).destroy
    @average = @profile.calculate_average
    render json: { user_id: @profile.id, average: @average }
  end

  private

  def rating_params
    params.require(:rating).permit(:value)
  end

  def set_profile
    @profile = User.find(params[:user_id])
  end
end
