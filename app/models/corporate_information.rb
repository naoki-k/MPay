class CorporateInformation < ApplicationRecord
  belongs_to :corporate_user, foreign_key: :user_id

  validates :address, presence: true
  validates :detail, length: { maximum: 65535 }
  validates :corporate_user, presence: true
end
