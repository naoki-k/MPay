module MyPage::TradeLogsHelper
  def change_sender_name_from_admin(trade)
    trade.sender.type == "AdminUser" ? "MPay" : trade.sender.name
  end
end
