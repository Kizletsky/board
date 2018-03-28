# frozen_string_literal: true

class UsersController < ApplicationController
  before_action :authenticate_user!, except: [:show]
  before_action :set_user, except: [:index]
  before_action :check_if_admin, except: %i[show edit]
  before_action :rated, only: [:show]

  def index
    # check if admin
    @users = User.all
  end

  def show
    # set user
  end

  def edit
    # set user
    if current_user == @user
      # redirect_to devise action
      redirect_to edit_user_registration_path
    else
      # if current user is admin then render our own edit view, cause it doesn't
      # make sense to let admin change user's login and password
      # admin only can change username, user role and avatar, as well as delete
      # whole user profile
      check_if_admin
    end
  end

  def update
    if @user.update(user_params)
      redirect_to @user, success: 'User profile updated'
    else
      render :edit
    end
  end

  def destroy
    # check if admin
    # set user
    @user.destroy
    respond_to do |format|
      format.js
      format.html { redirect_to users_path, success: 'User has been deleted' }
    end
  end

  private

  def check_if_admin
    redirect_to root_path, alert: 'You are not an admin !' unless
    current_user.admin?
  end

  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:username, :avatar, :avatar_cache, :role)
  end

  def rated
    @rated_by_current = @user.ratings.find_by(author_id: current_user.id) if
    user_signed_in?
  end
end
