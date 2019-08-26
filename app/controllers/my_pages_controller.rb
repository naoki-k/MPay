class MyPagesController < ApplicationController
  include Authority
  before_action :require_sign_in

  def show
    @user = current_user
    @credit_payment = @user.credit_payment
    @corporate_information = @user.corporate_information if @user.CorporateUser?
    
    render "my_pages/#{@user.type_camel}/show"
  end
end
