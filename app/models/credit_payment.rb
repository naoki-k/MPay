class CreditPayment < Payment
  belongs_to :user, inverse_of: :credit_payment

  def balance
    passive_trades.sum(:amount) - active_trades.reject {|trade| trade.type == :charge }.pluck(:amount).sum
  end
end
