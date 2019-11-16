Rails.application.routes.draw do
  root 'top_pages#home'
  get '/help', to: 'top_pages#help'
  get '/contact', to: 'top_pages#contact'
  
  devise_for :users
end
