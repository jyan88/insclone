class BlogsController < ApplicationController
  before_action :set_blog, only: [:show, :edit, :update, :destroy] 
  
  def index
    @blogs = Blog.all
    #binding.pry
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
  end
  
  def destroy
    @blog.destroy
    redirect_to blogs_path, notice:"ツイートを削除しました！"
  end
  
  def confirm
    @blog = Blog.new(blog_params)
    render :new if @blog.invalid?
  end

  private

  def blog_params
    params.require(:blog).permit(:title, :content)
  end
  
  def set_blog
    @blog = Blog.find(params[:id])
  end
end