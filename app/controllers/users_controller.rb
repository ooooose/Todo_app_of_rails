class UsersController < ApplicationController
  before_action :logged_in_user, only: [:index, :edit, :update, :destroy]

  def index
    @users = User.all
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    @user.image_name = "default_user.jpg"
    if @user.save
      flash[:success] = "サインインに成功しました！！"
      redirect_to root_url
    else
      render("users/new")
    end
  end

  def show
    @user = User.find(params[:id])
  end

  def edit
    @user = User.find_by(id: params[:id])
  end

  def update
    @user = User.find_by(id: params[:id])
    if params[:user][:image]
      @user.image_name = "#{@user.id}.jpg"
      image = params[:user][:image]
      File.binwrite("public/user_images/#{@user.image_name}", image.read)
    end
    byebug
    if @user.update(user_params.merge(image_name: @user.image_name))
      flash[:success] = "ユーザー情報を更新しました"
      redirect_to @user
    else
      render('users/edit')
    end
  end

  def destroy
    @user = User.find_by(id: params[:id])
    @user.destroy
    flash[:success]= "ユーザーを削除しました。"
    redirect_to users_url
  end

  private
    def user_params
      params.require(:user).permit(:name, :email,:password,:password_confirmation)
    end
end
