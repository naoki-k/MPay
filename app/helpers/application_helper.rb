module ApplicationHelper
  def signup_title(path)
    if [new_users_admin_path, new_users_personal_path, new_users_corporate_path].include?(path)
      "新規登録"
    end
  end
end
