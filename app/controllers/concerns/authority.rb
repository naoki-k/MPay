module Authority
  def admin_user
    unless current_user&.AdminUser?
      flash[:danger] = "管理者としてログインしてください"
      redirect_to sign_in_url
    end
  end

  def require_sign_in
    unless signed_in?
      flash[:danger] = "ログインしてください。"
      redirect_to sign_in_url
    end
  end

  def correct_type(type)
    case type
    when "AdminUser" then
      unless current_user.AdminUser?
        flash[:danger] = "管理者用のページです。"
        redirect_to sign_in_url
      end
    when "CorporateUser" then
      unless current_user.CorporateUser?
        flash[:danger] = "企業ユーザー用のページです。"
        redirect_to sign_in_url
      end
    when "PersonalUser" then
      unless current_user.PersonalUser?
        flash[:danger] = "個人ユーザー用のページです。"
        redirect_to sign_in_url
      end
    end
  end
end
