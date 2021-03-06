Rails.application.routes.draw do

  get 'rankings/index'
  devise_for :admins,skip:[:sessions],:controllers =>{
    :passwords => "admins/passwords"
  }

  devise_scope :admin do
    get "admins/sign_in", to: "admins/sessions#new"
    post "admins/sign_in", to: "admins/sessions#create"
    delete "admins/sign_out",to: "admins/sessions#destroy"
  end

  namespace :admins do
    resources :users,only:[:index,:show,:update,:edit]
    resources :mysteries,only:[:index,:show,:destroy]
    resources :genres,only:[:index,:create,:destroy]
    resources :comments,only:[:index]
  end

  devise_for :users,skip:[:sessions],:controllers => {
    :registrations => "users/registrations",
    :passwords => "users/passwords"
  }

  devise_scope :user do
    get "sign_in", to: "users/sessions#new"
    post "sign_in", to: "users/sessions#create"
    delete "sign_out", to: "users/sessions#destroy"
    get "sign_up", to: "users/registrations#new"
    post "sign_up", to: "users/registrations#create"
  end

  root to: "homes#top"
  get "about", to: "homes#about"

  get "users/:id/unsubscribe", to: "users#unsubscribe",as:"unsubscribe"
  patch "users/:id/withdraw", to: "users#withdraw",as:"withdraw"
  resources :users,only:[:show,:edit,:update] do
      # フォロー機能
    resource :relationships,only:[:create,:destroy]
    get "followings",to: "relationships#followings",as: "followings"
    get "followers",to: "relationships#followers",as: "followers"
    get "favorites",to: "favorites#index",as: "favorites"
  end

  get "mysteries/:id/answer",to: "mysteries#answer",as: "answer"
  resources :mysteries do
    # コメント機能
    resources :comments,only:[:create,:update,:edit,:destroy]

    # お気に入り機能
    resource :favorites,only:[:create,:destroy]
  end

  get "search", to: "searches#search"
  get "rankings", to: "rankings#index"

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
