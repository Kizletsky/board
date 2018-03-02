class UsersController < ApplicationController

  before_action :authenticate_user!, except: [:show]
  before_action :set_user, except: [:index]
  before_action :check_if_admin, except: [:show]

  def index
    # check if admin
    @users = User.all
  end

  def show
    # set_user
  end

  def destroy
    # check if admin
    # set user
    # destroy all posts created by this user and user
    @user.posts.each { |p| p.destroy}
    @user.destroy
    redirect_to users_path, success: "User has been deleted !"
  end

  private

  def check_if_admin
    redirect_to root_path, alert: "You are not an admin !" unless current_user.admin?
  end

  def set_user
    @user = User.find(params[:id])
  end

end
