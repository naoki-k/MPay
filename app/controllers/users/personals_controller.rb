class Users::PersonalsController < ApplicationController
  def new
    @user = PersonalUser.new
  end

  def show

  end

  def edit
    
  end

  def create
    @user = PersonalUser.new(user_params)
    if @user.save
      flash[:success] = ""
      redirect_to new_users_personal_path
    else
      flash.now[:danger] = ""
      render :new
    end
  end

  def update

  end

  private
    def user_params
      params.require(:personal_user).permit(:name, :tel, :email, :password, :password_confirmation)
    end
end
