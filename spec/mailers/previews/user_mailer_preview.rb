
# mailers can preview in http://localhost:3000/rails/mailers
class UserMailerPreview < ActionMailer::Preview
  def welcome_email
    UserMailer.welcome_email(user_with_token)
  end

  def account_activation
    UserMailer.account_activation(user_with_token)
  end

  private

    def user_with_token
      @user ||= User.find_by(email: "preview@example.com")
      @user ||= PersonalUser.create({
        name: "preview",
        tel: "123-4567-8910",
        email: "preview@example.com",
        password: "password",
        password_confirmation: "password",
      })
      @user.update_attribute(:activation_digest, BCrypt::Password.create(token))
      @user.update_attribute(:activated, false)
      @user.activation_token = token
      @user
    end

    def token
      "tekitouna-token-desu"
    end
end
