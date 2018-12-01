class BlogsController < ApplicationController
  before_action :set_blog, only: [:show, :edit, :update, :destroy]
  before_action :logged_in_user, only: [:new, :edit, :destroy, :index, :update]
  before_action :ensure_correct_user, only: [:update, :destroy, :edit]
  
  
  def index
    @blogs = Blog.all
    #binding.pry
    @current_user = current_user
  end

  def new
    if params[:back]
      @blog = Blog.new(blog_params)
    else
      @blog = Blog.new
    end
  end
  
  def edit
    @blog = Blog.find(params[:id])
  end
  
  def update
    @blog = Blog.find(params[:id])
    if @blog.update(blog_params)
      redirect_to blogs_path, notice: "ツイートを編集しました！"
    else
      render 'edit'
    end
  end

  def create
    @blog = Blog.new(blog_params)
    @blog.user_id = current_user.id #現在ログインしているuserのidを、blogのuser_idカラムに挿入する
    if @blog.save
      # 一覧画面へ遷移して"ツイートを作成しました！"とメッセージを表示します。
      redirect_to blogs_path, notice: "ツイートを作成しました！"
    else
      # 入力フォームを再描画します。
      render 'new'
    end
  end
  
  def show
    @blog = Blog.find(params[:id])
    @favorite = current_user.favorites.find_by(blog_id: @blog.id)
  end
  
  def destroy
    @blog.destroy
    redirect_to blogs_path, notice:"ツイートを削除しました！"
  end
  
  def confirm
    @blog = Blog.new(blog_params)
    @blog.user_id = current_user.id #現在ログインしているuserのidを、blogのuser_idカラムに挿入する
    render :new if @blog.invalid?
  end
  
  private
  
  def blog_params
    params.require(:blog).permit(:title, :content, :image, :image_cache)
  end
  
  def set_blog
    @blog = Blog.find(params[:id])
  end
  
  def logged_in_user
    unless current_user 
      flash[:referer] = 'ログインしてください'
      render new_session_path
    end
  end
  
  def ensure_correct_user
    @blog = Blog.find_by(id:params[:id])
    if @blog.user_id != @current_user.id
      flash[:notice] = "権限がありません"
      redirect_to blog_path
    end
  end
end
