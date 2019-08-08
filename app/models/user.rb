class User < ApplicationRecord
  has_one :credit_payment
  has_many :bank_payments
  has_many :active_relationships, class_name: :Relationship,
                                  foreign_key: :following_user_id,
                                  dependent: :destroy
  has_many :passive_relationships, class_name: :Relationship,
                                   foreign_key: :followed_user_id,
                                   dependent: :destroy
  has_many :following_users, through: :active_relationships
  has_many :followed_users, through: :passive_relationships
  has_many :active_billings, class_name: :Billing,
                              foreign_key: :sender_id,
                              dependent: :destroy
  has_many :passive_billings, class_name: :Billing,
                              foreign_key: :receiver_id,
                              dependent: :destroy

  accepts_nested_attributes_for :credit_payment

  enum type: [:AdminUser, :PersonalUser, :CorporateUser]

  validates :credit_payment, presence: true
  validates :tel, presence: true, uniqueness: true, length: { maximum: 25 }
  validates :type, presence: true, length: { maximum: 25 }
  validates :name, length: { maximum: 25 }
  validates :email, length: { maximum: 255 }

  def tradable?
    credit_payment.is_active || bank_payment&.tradable.present?
  end
end
