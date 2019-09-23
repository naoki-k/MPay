class MyPage::FriendListsController < ApplicationController
  protect_from_forgery except: :search

  include Authority
  before_action :require_sign_in

  def friends
    @users = current_user.friends
    respond_to do |format|
      format.json { render json: @users.map {|user| user.slice(:id, :name) } }
    end
  end

  def followings
    @users = current_user.followings
    respond_to do |format|
      format.json { render json: @users.map {|user| user.slice(:id, :name) } }
    end
  end

  def followers
    @users = current_user.followers
    respond_to do |format|
      format.json { render json: @users.map {|user| user.slice(:id, :name) } }
    end
  end

  def search
    if params[:keyword]&.present?
      @users = User.where('name LIKE ?', "%#{ActiveRecord::Base.sanitize_sql_like(params[:keyword])}%")
      respond_to do |format|
        format.json { render json: @users.map {|user| user.slice(:id, :name) } }
      end
    end
  end
end
