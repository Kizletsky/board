class UsersController < ApplicationController

  before_action :authenticate_user!, except: [:show]
  before_action :set_user, except: [:index]
  before_action :check_if_admin, except: [:show]

  def index
    # check if admin
    @users = User.all
  end

  def show
    # set user
  end

  def edit
    # set user
    #check if admin
  end

  def update
    if @user.update_attributes(user_params)
      redirect_to @user , success: "User profile updated"
    else
      render :edit
    end
  end

  def destroy
    # check if admin
    # set user
    @user.destroy
     respond_to do |format|
       format.js { flash.now[:success] = "User has been deleted !"}
     end
  end

  private

  def check_if_admin
    redirect_to root_path, alert: "You are not an admin !" unless current_user.admin?
  end

  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:username, :avatar, :avatar_cache, :role)
  end

end
