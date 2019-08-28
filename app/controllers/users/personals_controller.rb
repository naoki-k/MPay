class Users::PersonalsController < ApplicationController
  include ProfileImageUploader

  def new
    @user = PersonalUser.new
  end

 def edit

  end

  def create
    @user = PersonalUser.new(user_params)
    if @user.save
      UserMailer.account_activation(@user).deliver_now
      flash[:success] = "仮登録が完了しました。メールから本登録をお願い致します。"
      redirect_to new_users_personal_url
    else
      flash.now[:danger] = "登録に失敗しました。"
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
