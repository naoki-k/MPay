class Trade < ApplicationRecord
  belongs_to :active_payment, class_name: :Payment
  belongs_to :passive_payment, class_name: :Payment
  has_one :billing

  enum kind: { common: 0, qr: 1 }

  validates :amount, presence: true

  def type
    sender = active_payment.user
    receiver = passive_payment.user

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
