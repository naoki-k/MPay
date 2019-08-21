class Users::CorporatesController < ApplicationController
  def new
    @user = CorporateUser.new
  end

  def show

  end

  def edit

  end

  def create
    @user = CorporateUser.new(user_params)
    @information = CorporateInformation.new(information_params)
    if @user.save
      UserMailer.account_activation(@user).deliver_now
      flash[:success] = "仮登録が完了しました。メールから本登録をお願い致します。"
      @information.corporate_user = @user
      flash[:info] = "企業情報の登録に失敗しました。" unless @information.save
      redirect_to new_users_corporate_url
    else
      flash.now[:danger] = "登録に失敗しました。"
      render :new
    end
  end

  def update

  end

  private
    def user_params
      params.require(:corporate_user).permit(:name, :tel, :email, :password, :password_confirmation)
    end

    def information_params
      params.require(:corporate_user).permit(corporate_information: [:address, :detail])[:corporate_information]
    end
end
