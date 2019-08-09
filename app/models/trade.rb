class Trade < ApplicationRecord
  belongs_to :active_payment, class_name: :Payment
  belongs_to :passive_payment, class_name: :Payment
  has_one :sender, through: :active_payment, source: :user
  has_one :receiver, through: :passive_payment, source: :user
  has_one :billing

  enum kind: { common: 0, qr: 1 }

  validates :amount, presence: true

  def type
    if sender == receiver
      :charge
    elsif sender.AdminUser?
      :from_mpay
    elsif receiver.CorporateUser?
      :to_corporate
    elsif receiver.PersonalUser?
      :with_personal_user
    end
  end
end
