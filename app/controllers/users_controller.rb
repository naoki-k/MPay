class UsersController < ApplicationController
  include Authority
  before_action :admin_user, only: [:index, :destroy]
  before_action :require_sign_in, only: :show

  def index
    if params[:type] == "AdminUser"
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

  def show
    @user = User.find_by_id(params[:id])
    if @user == current_user
      redirect_to my_page_url
    else
      if @user
        @corporate_information = @user.corporate_information if @user.CorporateUser?
        render "users/#{@user.group}/show"
      else
        redirect_to "/"
      end
    end
  end
end

