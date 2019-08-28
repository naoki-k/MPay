class ProfileImage < ApplicationRecord
  include ProfileImage::Handler

  before_save Proc.new { self.image = to_base64(self.image) }

  belongs_to :user

  validates :image, presence: true
end
