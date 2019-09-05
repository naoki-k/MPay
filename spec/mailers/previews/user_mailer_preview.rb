
# mailers can preview in http://localhost:3000/rails/mailers
class UserMailerPreview < ActionMailer::Preview
  def welcome_email
    UserMailer.welcome_email(user_with_token)
  end

  def account_activation
    UserMailer.account_activation(user_with_token)
  end

  def account_activate_request
    UserMailer.account_activate_request(user)
  end

  private

    def user_with_token
      @user ||= user
      @user.account_activation.update_attribute(:digest, BCrypt::Password.create(token))
      @user.account_activation.update_attribute(:activated, false)
      @user.activation_token = token
      @user
    end

    def user
      @user ||= User.find_by(email: "preview@example.com")
      @user ||= PersonalUser.create({
        name: "preview",
        tel: "123-4567-8910",
        email: "preview@example.com",
        password: "password",
        password_confirmation: "password",
      })
    end

    def token
      "tekitouna-token-desu"
    end
end
