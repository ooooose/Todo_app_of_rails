class UsersController < ApplicationController

  def index
    @users = User.all
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
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
      params.require(:user).permit(:name, :email)
    end

end
