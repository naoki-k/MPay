class TradesController < ApplicationController
  def new
    @trade = Trade.new
  end

  def create
    target_payment = User.find_by_id(params[:target_user_id])&.credit_payment
    if target_payment
      @trade = Trade.new(active_payment: current_user.credit_payment,
                         passive_payment: target_payment,
                         amount: params[:amount])
      if @trade.save
        flash[:success] = "取引が正常に行われました。"
        redirect_to new_trade_url
      else
        flash[:error] = "取引に失敗しました。"
        redirect_to new_trade_url
      end
    end
  end

  def confirmation
    @user = User.find_by(code: params[:target_user_code])
    @amount = params[:amount]
    render
  end
end
