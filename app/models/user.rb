class User < ApplicationRecord
  include User::Friend

  before_validation :create_mpay_credit, on: :create
  after_create :create_user_code

  has_many :payments, dependent: :destroy
  has_one :credit_payment
  has_many :bank_payments
  has_many :active_trades, through: :payments
  has_many :passive_trades, through: :payments
  has_many :active_relationships, class_name: :Relationship,
                                  foreign_key: :follower_id,
                                  dependent: :destroy
  has_many :passive_relationships, class_name: :Relationship,
                                   foreign_key: :followed_id,
                                   dependent: :destroy
  has_many :following, through: :active_relationships, source: :followed
  has_many :followers, through: :passive_relationships
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
  validates :name, presence: true, length: { maximum: 25 }
  validates :email, presence: true, uniqueness: true, length: { maximum: 255 }
  validates :password, presence: true, length: { in: 6..30 }

  attr_accessor :activation_token

  has_secure_password

  def tradable?
    credit_payment.is_active || bank_payments&.tradable.present?
  end

  def trades
    (active_trades + passive_trades).uniq.sort_by(&:created_at)
  end

  def send_path
    case type
    when "AdminUser" then "users_admins_path"
    when "CorporateUser" then "users_corporates_path"
    when "PersonalUser" then "users_personals_path"
    end
  end

  def get_path
    case type
    when "AdminUser" then "new_users_admin_path"
    when "CorporateUser" then "new_users_corporate_path"
    when "PersonalUser" then "new_users_personal_path"
    end
  end

  def group
    case type
    when "AdminUser" then "admins"
    when "CorporateUser" then "corporates"
    when "PersonalUser" then "personals"
    end
  end

  def authenticated?(token)
    BCrypt::Password.new(activation_digest).is_password?(token)
  end

  private

    def create_mpay_credit
      build_credit_payment(number: SecureRandom.alphanumeric(16), is_active: false)
    end

    def create_user_code
      update_attribute(:code, SecureRandom.alphanumeric(12) + id.to_s)
    end

    def digest(string)
      BCrypt::Password.create(string)
    end
end
