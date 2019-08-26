class MyPage::TradeLogsController < ApplicationController
  include Authority
  before_action :require_sign_in

  def show
    @trades = current_user.trades
  end
end
