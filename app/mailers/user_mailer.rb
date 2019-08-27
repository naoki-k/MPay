class UserMailer < ApplicationMailer
  default from: %(MPay[みんなのペイ] <mpay_notice@example.com>)

  def welcome_email(user)
    @user = user
    mail to: email_with_name(user), subject: "ご登録が完了しました。", template_path: "user_mailer/#{user.group}"
  end

  def account_activation(user)
    @user = user
    mail to: email_with_name(user), subject: "【重要】本登録をお願いいたします。", template_path: "user_mailer/#{user.group}"
  end

  def account_activate_request(user)
    @user = user
    mail to: "mpay_notice@example.com", subject: "アカウント有効化の申請があります。", template_path: "user_mailer/admins"
  end

  private

    def email_with_name(user)
      %(#{@user.name} <#{@user.email}>)
    end
end
