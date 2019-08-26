Rails.application.routes.draw do

  # ユーザー
  resources :users, only: [:destroy, :index, :show]
  namespace :users do
    resources :admins, :corporates, only: [:new, :create]
    resources :corporates, only: [:new, :create, :update, :edit]
    resources :personals, only: [:new, :create, :update, :edit], path: ""
  end

  # マイページ
  resource :my_page, only: :show

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
end
