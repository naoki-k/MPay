class Trade < ApplicationRecord
  belongs_to :active_payment, class_name: :Payment
  belongs_to :passive_payment, class_name: :Payment
  has_one :billing

  validates :amount, presence: true

  def type
    sender = active_payment.user
    receiver = passive_payment.user

    if sender == receiver
      :charge
    elsif sender.admin?
      :from_mpay
    elsif receiver.corporate?
      :to_corporate
    elsif receiver.personal?
      :with_personal_user
    end
  end
end
