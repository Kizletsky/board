Rails.application.routes.draw do
  root "posts#index"
  devise_for :users
  resources :posts do
    resources :comments, except: [:show, :index]
  end
  resources :users, except: [:create, :new] do
    resources :ratings, only: [:create, :destroy]
  end
  resources :tags, only: [:show, :create]
  resources :favorites, only: [:index, :create, :destroy]
end
