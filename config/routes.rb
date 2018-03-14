Rails.application.routes.draw do
  post '/rate' => 'rater#create', :as => 'rate'
  root "posts#index"
  devise_for :users
  resources :posts do
    resources :comments, except: [:show, :index]
  end
  resources :users, except: [:create, :new]
  resources :tags, only: [:show, :create]
end
