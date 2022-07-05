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
      redirect_to("/users")
    else
      flash[:notice] = "失敗です！！"
      render("users/new")
    end
  end

  def edit
  end

  private
    def user_params
      params.require(:user).permit(:name, :email)
    end

end
