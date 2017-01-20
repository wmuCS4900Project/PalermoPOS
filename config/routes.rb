Rails.application.routes.draw do
  resources :customers
  get 'sessions/new'
  get 'users/new'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  
  root 'application#home'
  resources :users
  resources :products
  resources :categories
  resources :options

  get "default/index" 
  post "orders/pickoptions" => 'orders#pickoptions'
  get "orders/cashout" => 'orders#cashout'
  get "orders/all" => 'orders#all'
  post "orders/cashedout" => 'orders#cashedout'
  post "orders/confirmorder" => 'orders#confirmorder'
  get "orders/custsearch" => 'orders#custsearch'
  get "orders/startorder" => 'orders#startorder'
  get "orders/pending" => 'orders#pending'
  resources :orders
  
  # Route Signup to new users page
  get  '/signup',  to: 'users#new'

  # Route Logins to Sessions controller
  get    '/login',   to: 'sessions#new'
  post   '/login',   to: 'sessions#create'
  delete '/logout',  to: 'sessions#destroy'
end
