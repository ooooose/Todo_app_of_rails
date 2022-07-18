class ApplicationController < ActionController::Base
  include SessionsHelper

  def logged_in_user
    unless logged_in?
      redirect_to login_url
    end
  end
  
  def ensure_correct_user
    user = User.find(params[:id])
    unless current_user?(user)
      flash[:danger] = "権限がありません"
      redirect_to root_url
    end
  end
end
