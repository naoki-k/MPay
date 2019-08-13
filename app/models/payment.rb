class Payment < ApplicationRecord
  before_save :encrypt_number

  has_many :active_trades, class_name: :Trade,
                           foreign_key: :active_payment_id
  has_many :passive_trades, class_name: :Trade,
                            foreign_key: :passive_payment_id
  belongs_to :user

  enum type: [:BankPayment, :CreditPayment]

  validates :number, presence: true, length: { maximum: 255 }
  validates :is_active, inclusion: { in: [true, false] }

  def encrypt_number
    self.number = encrypt(self.number)
  end

  def decrypted_number
    decrypt(number)
  end

  private

    def encrypt(string)
      @crypt ||= ActiveSupport::MessageEncryptor.new(secret_key_base_32_bytes, cipher: "aes-256-cbc")
      @crypt.encrypt_and_sign(string)
    end

    def decrypt(string)
      @crypt ||= ActiveSupport::MessageEncryptor.new(secret_key_base_32_bytes, cipher: "aes-256-cbc")
      @crypt.decrypt_and_verify(string)
    end

    # TODO: このインスタンスが持つのはおかしいかも
    def secret_key_base_32_bytes
      Rails.application.secrets[:secret_key_base].byteslice(0, 32)
    end
end
