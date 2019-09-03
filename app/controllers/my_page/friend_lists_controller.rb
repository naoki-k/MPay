class MyPage::FriendListsController < ApplicationController
  protect_from_forgery except: :search

  include Authority
  before_action :require_sign_in

  def show
  end

  def search
    if params[:keyword].present?
      @users = User.where('name LIKE ?', "%#{ActiveRecord::Base.send(:sanitize_sql_like, params[:keyword])}%")
      respond_to do |format|
        format.json { render json: @users }
      end
    end
  end
end
