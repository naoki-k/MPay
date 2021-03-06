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
end
