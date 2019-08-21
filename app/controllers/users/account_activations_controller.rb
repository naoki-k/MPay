class AccountActivationsController < ApplicationController
  def edit
    def edit
      user = User.find_by(email: params[:email])
      if user && !user.activated? && user.authenticated?(params[:id])
        user.update_attribute({activated: true, activated_at: Time.zone.now})
        flash[:success] = "本登録が完了しました。"
        redirect_to root_url
      else
        flash[:danger] = "無効なリンクです。"
        redirect_to root_url
      end
    end
  end
end
