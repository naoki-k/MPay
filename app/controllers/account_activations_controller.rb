class AccountActivationsController < ApplicationController
  include Authority

  before_action :admin_user, only: :authorize

  def edit
    user = User.find_by(email: params[:email])
    if user && !user.activated? && user.authenticated?(params[:id])
      activate(user)
      user.credit_payment.update_attribute(:is_active, true)
      present_benefit_for(user)
      flash[:success] = "本登録が完了しました。"
      UserMailer.welcome_email(user).deliver_now
      redirect_to send(user.get_path)
    else
      flash[:danger] = "無効なリンクです。"
      redirect_to "/"
    end
  end

  def authorize
    user = User.find_by_id(params[:id])
    if user
      if user.activated?
        flash.now[:danger] = "このユーザーは有効化済みです。"
        render "users/index"
      else
        activate(user)
        user.credit_payment.update_attribute(:is_active, true)
        flash[:success] = "ユーザーを有効化しました。"
        UserMailer.welcome_email(user).deliver_now
        redirect_to users_url(type: params[:type])
      end
    else
      flash.now[:danger] = "ユーザーが存在しません。"
      render "users/index"
    end
  end

  private

    def activate(user)
      user.update_attribute(:activated, true)
      user.update_attribute(:activated_at, Time.zone.now)
    end

    def present_benefit_for(user)
      Trade.create(passive_payment: user.credit_payment,
                   active_payment: AdminUser.first.credit_payment,
                   amount: 10000)
    end
end
