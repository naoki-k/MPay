class UserMailer < ApplicationMailer
  default from: %(MPay[みんなのペイ] <mpay_notice@example.com>)

  def welcome_email(user)
    @user = user
    email_with_name = %(#{@user.name} <#{@user.email}>)
    mail to: email_with_name, subject: "ご登録が完了しました。", template_path: "user_mailer/#{user.type_camel}"
  end

  def account_activation(user)
    @user = user
    email_with_name = %(#{@user.name} <#{@user.email}>)
    mail to: email_with_name, subject: "【重要】本登録をお願いいたします。", template_path: "user_mailer/#{user.type_camel}"
  end
end
