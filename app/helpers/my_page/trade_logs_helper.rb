module MyPage::TradeLogsHelper
  def receiver?(trade)
    return true if current_user.name == trade.receiver.name
  end
end
