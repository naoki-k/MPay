class Trade < ApplicationRecord
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
    @type ||=
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

  def type_ja
    case type
    when :charge then "入金"
    when :from_mpay then "MPayからの支払い"
    when :to_corporate then "法人への支払い"
    when :with_personal_user then "ユーザー間取引"
    end
  end

  private

    def tradable
      unless active_payment&.is_active?
        errors.add(:active_payment, "は無効なMPay口座です。")
      end
      unless passive_payment&.is_active?
        errors.add(:passive_payment, "は無効なMPay口座です。")
      end
      if active_payment&.CreditPayment? && !active_payment&.payable?(amount)
        errors.add(:active_payment, "は残高を超えた支払いができません。")
      end
    end
end
