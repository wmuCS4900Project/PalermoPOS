Rails.application.routes.draw do
  get 'users/new'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  
  root 'application#hello'
  resources :users
  resources :products
  resources :categories

  post "orders/pickoptions" => 'orders#pickoptions'
  post "orders/confirmorder" => 'orders#confirmorder'
  get "orders/custsearch" => 'orders#custsearch'
  get "orders/startorder" => 'orders#startorder'
  get "orders/pending" => 'orders#pending'
  resources :orders
  get  '/signup',  to: 'users#new'

end