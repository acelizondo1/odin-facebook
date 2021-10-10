Rails.application.routes.draw do
  devise_for :users, :controllers => { registrations: 'registrations' }

  resources :users, only: [:index, :show]
  resources :friendships, only: [:create, :destroy]
  root "users#index"
end
