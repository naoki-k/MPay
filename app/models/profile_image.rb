class ProfileImage < ApplicationRecord
  include ProfileImageDelegator

  before_save proc self.image = to_base64(image)

  belongs_to :user

  validates :image, presence: true
end
