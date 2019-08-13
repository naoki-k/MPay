class User < ApplicationRecord
  before_validation :create_mpay_credit, on: :create

  has_many :payments
  has_one :credit_payment
  has_many :bank_payments
  has_many :active_trades, through: :payments
  has_many :passive_trades, through: :payments
  has_many :active_relationships, class_name: :Relationship,
                                  foreign_key: :following_user_id,
                                  dependent: :destroy
  has_many :following_users, through: :active_relationships
  has_many :passive_relationships, class_name: :Relationship,
                                   foreign_key: :followed_user_id,
                                   dependent: :destroy
  has_many :followed_users, through: :passive_relationships
  has_many :active_billings, class_name: :Billing,
                              foreign_key: :sender_id,
                              dependent: :destroy
  has_many :passive_billings, class_name: :Billing,
                              foreign_key: :receiver_id,
                              dependent: :destroy

  enum type: [:AdminUser, :PersonalUser, :CorporateUser]

  validates :credit_payment, presence: true
  validates :tel, presence: true, uniqueness: true, length: { maximum: 25 }
  validates :type, presence: true, length: { maximum: 25 }
  validates :name, length: { maximum: 25 }
  validates :email, length: { maximum: 255 }

  def tradable?
    credit_payment.is_active || bank_payment&.tradable.present?
  end

  def trades
    (active_trades + passive_trades).uniq.sort_by(&:created_at)
  end

  private

    def create_mpay_credit
      build_credit_payment(number: SecureRandom.alphanumeric(16), is_active: true)
    end
end
