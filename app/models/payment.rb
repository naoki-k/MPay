class Payment < ApplicationRecord
  has_many :active_trades, class_name: :Trade,
                           foreign_key: :active_payment_id
  has_many :passive_trades, class_name: :Trade,
                            foreign_key: :passive_payment_id

  enum type: [:BankPayment, :CreditPayment]

  validates :number, presence: true, length: { maximum: 255 }
  validates :is_active, inclusion: { in: [true, false] }
end
