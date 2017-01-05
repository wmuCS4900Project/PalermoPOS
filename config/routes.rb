Rails.application.routes.draw do
  get 'users/new'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  
  root 'application#hello'
  resources :users
  resources :orders
  resources :products
  resources :categories
  get "orders/new"
  post "/orders/new"
  post "/orders/pickoptions"
  post "/orders/confirmorder"

  get  '/signup',  to: 'users#new'
end
