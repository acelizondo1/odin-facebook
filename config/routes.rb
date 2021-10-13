Rails.application.routes.draw do
  
  devise_for :users, :controllers => { registrations: 'registrations' }

  resources :users, only: [:index, :show]
  resources :posts
  resources :friend_requests, only: [:index, :create, :update, :destroy]
  resources :friendships, only: [:index, :destroy]
  root "posts#index"
end
