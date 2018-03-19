class RatingsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_profile

  def create
    @rating = @profile.ratings.new(rating_params)
    @rating.author = current_user
    @rating.save
  end

  def destroy
    @profile.ratings.find(params[:id]).destroy
  end

  private

  def rating_params
    params.require(:rating).permit(:value)
  end

  def set_profile
    @profile = User.find(params[:user_id])
  end
end
