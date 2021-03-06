class PostsController < ApplicationController
  before_action :logged_in_user

  def index
    @posts = current_user.posts 
  end

  def show
    @post = current_user.posts.find(params[:id])
  end

  def new
    @post = Post.new
  end

  def create
    @post = current_user.posts.new(post_params)
    if @post.save
      flash[:success] = "投稿が成功しました"
      redirect_to posts_url
    else
      render("posts/new")
    end
  end

  def edit
    @post = current_user.posts.find(params[:id])
  end
  
  def update
    @post = current_user.posts.find(params[:id])
    @post.update(post_params)
    if @post.save
      flash[:success] = "投稿を更新しました"
      redirect_to @post
    else
      flash[:danger] = "更新に失敗しました"
      render 'edit'
    end
  end

  def destroy
    @post = current_user.posts.find(params[:id])
    @post.destroy
    flash[:success] = "投稿を削除しました"
    redirect_to posts_url
  end

  private
    def post_params
      params.require(:post).permit(:content)
    end

end
