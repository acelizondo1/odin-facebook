Rails.application.routes.draw do
  devise_for :users, :controllers => { registrations: 'registrations' }

  resources :users, only: [:index, :show]
  resources :friend_requests, only: [:index, :create, :update, :destroy]
  root "users#index"
end
