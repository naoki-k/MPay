class Users::AdminsController < ApplicationController
  include Authority
  before_action :require_sign_in, only: :show
  before_action -> { correct_type("AdminUser") }, only: :show

  def new
    @user = AdminUser.new
  end

  def show
    @user = current_user
    @credit_payment = @user.credit_payment
  end

  def edit
    
  end

  def create
    @user = AdminUser.new(user_params)
    if @user.save
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
