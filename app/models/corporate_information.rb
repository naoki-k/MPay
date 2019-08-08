class CorporateInformation < ApplicationRecord
  belongs_to :corporate_user

  validates :address, presence: true
  validates :detail, length: { maximum: 65535 }
end
