module MyPage::TradeLogsHelper
  def sender?(trade)
    return true if current_user.name == trade.sender.name
  end
end
