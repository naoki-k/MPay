class Trade < ApplicationRecord
  TYPE = { charge: "入金", from_mpay: "MPayからの支払い",
           to_corporate: "法人への支払い", with_personal_user: "ユーザー間取引" }.freeze

  belongs_to :active_payment, class_name: :Payment
  belongs_to :passive_payment, class_name: :Payment
  has_one :sender, through: :active_payment, source: :user
  has_one :receiver, through: :passive_payment, source: :user
  has_one :billing

  enum kind: { common: 0, qr: 1 }

  validates :amount, presence: true
  validates :active_payment, presence: true
  validates :passive_payment, presence: true
  validate :tradable

  def type
    if sender == receiver
      TYPE.slice(:charge)
    elsif sender.AdminUser?
      TYPE.slice(:from_mpay)
    elsif receiver.CorporateUser?
      TYPE.slice(:to_corporate)
    elsif receiver.PersonalUser?
      TYPE.slice(:with_personal_user)
    end
  end

  private

    def tradable
      if active_payment&.is_active?
        errors.add(:active_payment, "は無効なMPay口座です。")
      end
      if passive_payment&.is_active?
        errors.add(:passive_payment, "は無効なMPay口座です。")
      end
      if active_payment&.CreditPayment? && active_payment&.payable?(amount)
        errors.add(:active_payment, "は残高を超えた支払いができません。")
      end
    end
end
