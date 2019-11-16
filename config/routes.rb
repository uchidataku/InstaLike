Rails.application.routes.draw do
  root 'top_pages#home'
  get '/help', to: 'top_pages#help'
  get '/contact', to: 'top_pages#contact'
  get '/privacy_policy', to: 'top_pages#privacy_policy'
  
  devise_for :users, controllers: {
    registrations: 'users/registrations',
    sessions: 'users/sessions'
  }
    
  devise_scope :user do
    get '/users/:id', to: 'users#show', as: :user
    get '/users', to: 'users#index', as: :users
  end
end
