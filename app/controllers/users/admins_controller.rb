class Users::AdminsController < ApplicationController
  def new
    @user = AdminUser.new
  end

  def show

  end

  def edit
    
  end

  def create
    @user = AdminUser.new(user_params)
    if @user.save
      flash[:success] = "アカウント作成の申請をしました。"
      redirect_to new_users_admin_path
    else
      flash.now[:danger] = "アカウントの作成に失敗しました。"
      render :new
    end
  end

  def update

  end

  private
    def user_params
      params.require(:admin_user).permit(:name, :tel, :email, :password, :password_confirmation)
    end
end
