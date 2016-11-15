Rails.application.routes.draw do
  resources :orderlines
  resources :orders
  resources :options
  resources :customers
  resources :products
  resources :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  
  root 'application#hello'
  resources :queryspike1
end
