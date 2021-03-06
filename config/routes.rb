Rails.application.routes.draw do
  default_url_options :host => ENV['host']
  devise_for :users, :controllers => { registrations: 'registrations', omniauth_callbacks: 'users/omniauth_callbacks' }

  resources :users, only: [:index, :show, :edit, :update] do
    get 'suggest', on: :collection
  end

  resources :posts do 
    get 'user', on: :collection
    resources :comments, except: [:edit, :update]
  end
  
  resources :friend_requests, only: [:index, :create, :update, :destroy]
  resources :friendships, only: [:index, :destroy]

  resources :likes, only: [:index, :create, :destroy]
  resources :notifications, only: [:index, :create, :update, :destroy]

  devise_scope :user do
    authenticated :user do
      root to: 'posts#index', as: :authenticated_root
    end
  end
  root :to => "devise/sessions#new"  

  get '*path' => redirect('/') unless Rails.env.development?
end
