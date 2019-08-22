class UsersController < ApplicationController
  include Authority

  before_action :admin_user

  def index
    if params[:type]&.equal?("AdminUser")
      @users = AdminUser.where(activated: false).order("updated_at DESC").paginate(page: params[:page], per_page: 20)
    else
      @users = CorporateUser.where(activated: false).order("updated_at DESC").paginate(page: params[:page], per_page: 20)
    end
  end

  def destroy
    if User.find_by_id(params[:id])&.destroy
      flash[:success] = "ユーザーを削除しました。"
    end
    redirect_to users_url(type: params[:type])
  end
end
