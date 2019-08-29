class Users::AdminsController < ApplicationController
  def new
    @user = AdminUser.new
  end

  def edit
    
  end

  def create
    @user = AdminUser.new(user_params)
    @image = @user.build_profile_image(image: params[:profile_image]&.read)
    if @user.save
      flash[:info] = "プロフィール画像の設定に失敗しました" if params[:profile_image] && !@image.save
      UserMailer.account_activate_request(@user).deliver_now
      flash[:success] = "アカウント作成の申請をしました。"
      redirect_to new_users_admin_path
    else
      flash.now[:danger] = "アカウントの作成に失敗しました。"
      render :new
    end
  end

  def update

  end

  private
    def user_params
      params.require(:admin_user).permit(:name, :tel, :email, :password, :password_confirmation)
    end
end
