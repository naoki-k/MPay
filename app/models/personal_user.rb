class PersonalUser < User
  before_create :create_activation_digest

  attr_accessor :activation_token

  private

  def create_activation_digest
    self.activation_token = SecureRandom.urlsafe_base64
    account_activation.digest = digest(activation_token)
  end
end
