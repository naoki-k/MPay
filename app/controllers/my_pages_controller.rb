class MyPagesController < ApplicationController
  include Authority
  before_action :require_sign_in

  def show
    @user = current_user
    @credit_payment = @user.credit_payment
    @image = @user.profile_image&.image
    @corporate_information = @user.corporate_information if @user.CorporateUser?
    
    render "my_page/#{@user.group}/show"
  end
end
