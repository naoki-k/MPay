class AddBankToPayments < ActiveRecord::Migration[5.2]
  def change
    add_reference :payments, :bank, foreign_key: true
  end
end
