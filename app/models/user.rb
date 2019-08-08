class User < ApplicationRecord
  after_find :tradable

  has_many :payments, inverse_of: :user
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

  accepts_nested_attributes_for :payments

  enum type: [:AdminUser,:PersonalUser, :CorporateUser]

  validates :tel, presence: true, uniqueness: true, length: { maximum: 25 }
  validates :type, presence: true, length: { maximum: 25 }
  validates :name, length: { maximum: 25 }
  validates :email, length: { maximum: 255 }

  private

    def tradable
      puts "取引不能なユーザーなのでpayment登録画面へ誘導する" if payments.tradable.size < 1
    end
end
