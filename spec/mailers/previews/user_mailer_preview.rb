
# mailers can preview in http://localhost:3000/rails/mailers
class UserMailerPreview < ActionMailer::Preview
  def welcome_email
    UserMailer.welcome_email(PersonalUser.first)
  end

  def account_activation
    UserMailer.account_activation(PersonalUser.first)
  end
end
