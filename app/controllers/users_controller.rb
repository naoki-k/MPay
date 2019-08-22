class UsersController < ApplicationController
  def index
    if params[:type]&.equal?("AdminUser")
      @users = AdminUser.where(activated: false).order("updated_at DESC").paginate(page: params[:page])
    else
      @users = CorporateUser.where(activated: false).order("updated_at DESC").paginate(page: params[:page])
    end
  end

  def destroy
    User.find(params[:id]).destroy
    flash[:success] = "ユーザーを削除しました。"
    redirect_to users_url(type: params[:type])
  end
end
