class BankPayment < Payment
  belongs_to :bank

  validates :bank, presence: true

  scope :tradable, -> { where(is_active: true) }
end
