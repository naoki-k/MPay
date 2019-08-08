class Billing < ApplicationRecord
  belongs_to :sender, class_name: :User
  belongs_to :receiver, class_name: :User
  belongs_to :trade, optional: true

  enum kind: { online: 0, qr: 1 }

  validates :amount, presence: true
  validates :content, length: { maximum: 65535 }
end
