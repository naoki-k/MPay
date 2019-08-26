class Users::CorporatesController < ApplicationController
  include Authority
  before_action :require_sign_in, only: :show
  before_action -> { correct_type("CorporateUser") }, only: :show

  def new
    @user = CorporateUser.new
    @information = CorporateInformation.new
  end

  def show
    @user = current_user
    @corporate_information = @user.corporate_information
    @credit_payment = @user.credit_payment
  end

  def edit

  end

  def create
    @user = CorporateUser.new(user_params)
    @information = CorporateInformation.new(information_params)
    @information&.corporate_user = @user
    if ([@user, @information].map(&:valid?)).all?
      @user.save
      @information.save
      UserMailer.account_activate_request(@user).deliver_now
      flash[:success] = "アカウント作成の申請をしました。"
      redirect_to new_users_corporate_url
    else
      flash.now[:danger] = "アカウントの作成に失敗しました。"
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
