class UsersController < ApplicationController
  def index
    @users = User.where(activated: false, type: "CorporateUser")
  end

  def destroy

  end
end
