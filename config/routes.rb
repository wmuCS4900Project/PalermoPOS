Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  
  root 'application#hello'
  resources :users
  resources :products
  resources :categories
  get "orders" => 'orders'
  post "orders/new" => 'orders#new'
  post "orders/pickoptions" => 'orders#pickoptions'
  post "orders/confirmorder" => 'orders/confirmorder'
end
