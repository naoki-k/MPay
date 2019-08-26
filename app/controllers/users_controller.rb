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
    # current_user == @user の時、my_pageに飛ばす処理をあとで書きます。
    if @user
      @corporate_information = @user.corporate_information if @user.CorporateUser?
      render "users/#{@user.type_camel}/show"
    else
      redirect_to "/"
    end
  end
end
