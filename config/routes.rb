Rails.application.routes.draw do
  get 'sessions/new'

  get 'users/new'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  
  root 'application#hello'
  resources :users
  resources :orders
  resources :products
  resources :categories
  #resource :sessions, only: [:new, :create, :destroy] 
   
  get "orders/new"
  post "/orders/new"
  post "/orders/pickoptions"
  post "/orders/confirmorder"

  # Route Signup to new users page
  get  '/signup',  to: 'users#new'

  # Route Logins to Sessions controller
  get    '/login',   to: 'sessions#new'
  post   '/login',   to: 'sessions#create'
  delete '/logout',  to: 'sessions#destroy'
end
