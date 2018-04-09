# frozen_string_literal: true

Rails.application.routes.draw do
  root 'posts#index'
  mount ActionCable.server => '/cable'
  devise_for :users
  resources :posts do
    resources :comments, except: %i[show]
  end
  resources :users, except: %i[create new] do
    resources :ratings, only: %i[create destroy index]
  end
  resources :tags, only: %i[show create]
  resources :favorites, only: %i[index create destroy]
end
