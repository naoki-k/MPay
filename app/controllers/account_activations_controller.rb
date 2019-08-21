class AccountActivationsController < ApplicationController
  def edit
    user = User.find_by(email: params[:email])
    if user && !user.activated? && user.authenticated?(params[:id])
      user.update_attribute(:activated, true)
      user.update_attribute(:activated_at, Time.zone.now)
      flash[:success] = "本登録が完了しました。"
      UserMailer.welcome_email(user).deliver_now
      redirect_to send(user.get_path)
    else
      flash[:danger] = "無効なリンクです。"
      redirect_to send(user.get_path)
    end
  end
end
