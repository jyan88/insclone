class UsersController < ApplicationController
  before_action :correct_user, only: [:edit, :show, :edit, :update]
  
  def new
    @user = User.new
  end
  
  def create
    @user = User.new(user_params)
    if @user.save
      redirect_to new_session_path
    else
      render 'new'
    end
  end
  
  def show
    @user = User.find(params[:id])
    @favorites_blogs = @user.favorite_blogs
  end
  
  def edit
    @user = User.find(params[:id])
  end
  
  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      redirect_to user_path, notice: "ユーザー情報を変更しました！"
    else
      render 'edit'
    end
  end

  private
  
  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation, :image, :image_cache)
  end
  
  def set_user
    @user = User.find(params[:id])
  end
  
  def correct_user
    user = User.find(params[:id])
    if current_user != user
      redirect_to blog_path
    end
  end
  
end
