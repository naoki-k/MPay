class RelationshipsController < ApplicationController
  include Authority
  before_action :require_sign_in, :find_user
  protect_from_forgery except: [:create, :destroy]

  def create
    current_user.follow(@user)
    head :ok
  end

  def destroy
    current_user.unfollow(@user)
    head :ok
  end

  private

    def find_user
      redirect_to sign_in_url unless @user = User.find_by_id(params[:id])
    end
end
