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
      @information.corporate_user = @user
      if @information.save
        flash[:success] = ""
      end
      flash[:info] = ""
      redirect_to new_users_corporate_path
    else
      flash.now[:danger] = ""
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
