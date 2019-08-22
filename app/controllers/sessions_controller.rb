class SessionsController < ApplicationController
  def new
  end

  def create
    @user = User.find_by(email: params[:session][:email])
    if @user&.authenticate(params[:session][:password])
      if @user.activated?
        sign_in @user
        flash[:succees] = "ログインしました。"
        redirect_to "/"
      else
        flash.now[:danger] = "アカウントが有効化されていません。"
        render :new
      end
    else
      flash.now[:danger] = "ログイン情報に誤りがあります。"
      render :new
    end
  end
  
  def destroy
    sign_out
    flash[:succees] = "ログアウトしました。"
    redirect_to "/"
  end
end
