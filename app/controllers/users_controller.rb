class UsersController < ApplicationController
  before_action :correct_user, only: [:edit, :update, :show]
  
  def new
    @user = User.new
  end
  
  def create
    @user = User.new(user_params)
    if @user.save
      redirect_to user_path(@user.id)
    else
      render 'new'
    end
  end
  
  def show
    @user = User.find(params[:id])
    @favorites_blogs = @user.favorite_blogs
  end

  private
  
  def user_params
    params.require(:user).permit(:name, :email, :password,
                                 :password_confirmation)
  end
  
  def correct_user
    user = User.find(params[:id])
    if current_user != user
      redirect_to blog_path
    end
  end
end
