Rails.application.routes.draw do
  root 'top_pages#home'
  get '/help', to: 'top_pages#help'
  get '/contact', to: 'top_pages#contact'
  get '/privacy_policy', to: 'top_pages#privacy_policy'
  
  devise_for :users, controllers: {
    registrations: 'users/registrations',
    sessions: 'users/sessions',
    passwords: "users/passwords",
    omniauth_callbacks: 'users/omniauth_callbacks'
  }
    
  devise_scope :user do
    get '/users/:id', to: 'users#show', as: :user
    get '/users', to: 'users#index', as: :users
    get '/users/:id/following', to: 'users#following', as: :following_user
    get '/users/:id/followers', to: 'users#followers', as: :followers_user
  end
  
  resources :posts,         only: [:new, :create, :show, :destroy]
  resources :relationships, only: [:create, :destroy]
end
