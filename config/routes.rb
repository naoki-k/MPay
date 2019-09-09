Rails.application.routes.draw do

  # ユーザー
  resources :users, only: [:destroy, :index, :show]
  namespace :users do
    resources :admins, :corporates, only: [:new, :create]
    resources :corporates, only: [:new, :create, :update, :edit]
    resources :personals, only: [:new, :create, :update, :edit]
  end

  # マイページ
  resource :my_page, only: :show do
    scope module: :my_page do
      resource :trade_log, only: [:show]
      resource :friend_list, only: [:show]
    end
  end

  post "user_search", to: "my_page/friend_lists#search", defaults: { format: :json }

  # ログイン、ログアウト
  resources :sessions, only: :create
  get "sign_in", to: "sessions#new"
  delete "sign_out", to: "sessions#destroy"
  
  # アカウント有効化
  resources :account_activations, only: :edit
  get "authorize/:id", to: "account_activations#authorize", as: "authorize"

  # 取引
  resource :trade, only: [:new, :create]
  post "trade/confirmation", to: "trades#confirmation", as: "trade_confirmation"

  # フレンド
  resources :relationships, only: :destroy
  post "relationships/:id", to: "relationships#create", as: "relationships"
end
