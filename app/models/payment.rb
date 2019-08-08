class Payment < ApplicationRecord
  belongs_to :user, inverse_of: :payments
  has_many :active_trades, class_name: :Trade,
                           foreign_key: :active_payment_id
  has_many :passive_trades, class_name: :Trade,
                            foreign_key: :passive_payment_id

  enum kind: { credit: 0, bank: 1 }

  scope :tradable, -> { where(is_active: true) }

  validates :number, presence: true, length: { maximum: 255 }
  validates :is_active, inclusion: { in: [true, false] }

  def balance
    # return false unless kind == :credit

    passive_trades.sum(:amount) - active_trades.reject {|trade| trade.type == :charge }.pluck(:amount).sum
  end
end
