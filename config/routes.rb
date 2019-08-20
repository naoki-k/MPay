Rails.application.routes.draw do

  # ユーザー
  resources :users, only: :destroy
  namespace :users do
    resources :admins, :corporates, only: [:new, :create, :show]
    resources :corporates, only: [:new, :create, :update, :show, :edit]
    resources :personals, only: [:new, :create, :update, :show, :edit], path: ""
  end

  # ログイン、ログアウト
  resources :sessions, only: :create
  get "sign_in", to: "sessions#new"
  delete "sign_out", to: "sessions#destroy"
  
end
