Rails.application.routes.draw do
  root "posts#index"
  devise_for :users
  resources :posts do
    resources :comments
  end
  resources :users, except: [:create, :new]
  resources :tags, only: [:show, :create]
end
