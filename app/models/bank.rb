class Bank < ApplicationRecord
  has_many :bank_payments

  validates :name, length: { maximum: 25 }
  validates :code, length: { maximum: 25 }
end
