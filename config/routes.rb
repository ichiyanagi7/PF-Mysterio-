Rails.application.routes.draw do

  namespace :admins do
    get 'genres/index'
  end
  namespace :admins do
    get 'mysteries/index'
    get 'mysteries/show'
    get 'mysteries/destroy'
  end
  namespace :admins do
    get 'users/index'
    get 'users/show'
    get 'users/update'
  end
  get 'searches/search'
  get 'reviews/complete'
  get 'mysteries/show'
  get 'mysteries/new'
  get 'mysteries/create'
  get 'mysteries/edit'
  get 'mysteries/update'
  get 'mysteries/destroy'
  get 'mysteries/answer'
  get 'relationships/create'
  get 'relationships/destroy'
  get 'relationships/followings'
  get 'relationships/followers'
  get 'users/show'
  get 'users/edit'
  get 'users/update'
  get 'users/unsubscribe'
  get 'users/withdraw'
  devise_for :admins,skip:[:sessions],:controllers =>{
    :passwords => "admins/passwords"
  }

   devise_scope :admins do
    get "admins/sign_in", to: "admins/sessions#new"
    post "admins/sign_in", to: "admins/sessions#create"
    delete "admins/sign_out",to: "admins/sessions#destroy"
  end

  namespace :admins do
    resources :users,only:[:index,:show,:update]
    resources :mysteries,only:[:index,:show,:destroy]
    resources :genres,only:[:index,:create,:destroy]
  end

  devise_for :users,skip:[:sessions],:controllers => {
    :registrations => "users/registrations",
    :passwords => "users/passwords"
  }

  devise_scope :user do
    get "sign_in", to: "users/sessions#new"
    post "sign_in", to: "users/sessions#create"
    get "sign_out", to: "users/sessions#destroy"
    get "sign_up", to: "users/registrations#new"
  end

  root to: "homes#top"
  get "about", to: "homes#about"

  get "users/:id/unsubscribe", to: "users#unsubscribe"
  get "users/:id/withdraw", to: "users#withdraw"
  resources :users,only:[:show,:edit,:update]

  get "mysteries/:id/answer",to: "mystereies#answer"
  resources :mysteries,except:[:index] do
    # コメント機能
    resources :comments,only:[:create,:destroy]
    # レビュー機能
    resources :reviews,only:[:create]
    get "reviews/complete",to:"reviews#complete"
  end

  # フォロー機能
  resources :relationships,only:[:create,:destroy]
  get "followings",to: "relationships#followings",as: "followings"
  get "followers",to: "relationships#followers",as: "followers"

  get "search", to: "searches#search"

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
