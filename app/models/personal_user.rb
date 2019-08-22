class PersonalUser < User
  before_create :create_activation_digest

  private

  def create_activation_digest
    self.activation_token = SecureRandom.urlsafe_base64
    self.activation_digest = digest(activation_token)
  end
end
