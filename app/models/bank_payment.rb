class BankPayment < Payment
  belongs_to :bank
  belongs_to :user, inverse_of: :bank_payments

  validates :bank, presence: true

  scope :tradable, -> { where(is_active: true) }
end
