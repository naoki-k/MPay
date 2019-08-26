class CreditPayment < Payment
  def balance
    passive_trades.sum(:amount) - active_trades.reject {|trade| trade.type == :charge }.pluck(:amount).sum
  end

  def payable?(amount)
    if user.AdminUser?
      true
    else
      balance >= amount
    end
  end
end
