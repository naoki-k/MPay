class Users::PersonalsController < ApplicationController
  def new
    @user = PersonalUser.new
  end

 def edit

  end

  def create
    @user = PersonalUser.new(user_params)
    @image = @user.build_profile_image(image: params[:profile_image]&.read)
    if @user.save
      flash[:info] = "プロフィール画像の設定に失敗しました" if params[:profile_image] && !@image.save
      UserMailer.account_activation(@user).deliver_now
      flash[:success] = "仮登録が完了しました。メールから本登録をお願い致します。"
      redirect_to new_users_personal_url
    else
      flash.now[:danger] = "登録に失敗しました。"
      render :new
    end
  end

  def update

  end

  private
    def user_params
      params.require(:personal_user).permit(:name, :tel, :email, :password, :password_confirmation)
    end
end
