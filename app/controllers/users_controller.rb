class UsersController < ApplicationController
  before_action :logged_in_user, only: [:edit, :update, :destroy]

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
      flash[:notice] = "成功です！！"
      redirect_to users_url
    else
      flash[:notice] = "失敗です！！"
      render("users/new")
    end
  end

  def show
    @user = User.find_by(id: params[:id])
  end

  def edit
    @user = User.find_by(id: params[:id])
  end

  def update
    @user = User.find_by(id: params[:id])
    if params[:image]
      @user.image_name = "#{@user.id}.jpg"
      image = params[:image]
      File.binwrite("/public/user_images/#{@user.image_name}", image.read)
    end
    @user.update(user_params)
    if @user.save
      redirect_to @user
    else
      render('users/edit')
    end
  end

  def destroy
    @user = User.find_by(id: params[:id])
    @user.destroy
    redirect_to users_url
  end

  private
    def user_params
      params.require(:user).permit(:name, :email,:password,:password_confirmation, :image_name)
    end
end
