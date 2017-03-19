Rails.application.routes.draw do
  resources :palconfigs
  resources :customers
  get 'sessions/new'
  get 'users/new'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  
  root 'application#home'
  resources :users
  
  get "products/changeall" => 'products#changeall'
  post "products/changeallapply" => 'products#changeallapply'
  resources :products
  
  resources :categories
  
  get "options/changeall" => 'options#changeall'
  post "options/changeallapply" => 'options#changeallapply'
  resources :options
  
  post "coupons/save" => 'coupons#save'
  resources :coupons
  
  resources :caps
  resources :roles
  
  get "management" => 'management#index'
  get "management/cashoutdrivers" => 'management#cashoutdrivers'
  get "management/endofday" => 'management#endofday'

  get "orders/addPreviousOrderItems" => 'orders#addPreviousOrderItems'
  post "orders/commitorder" => 'orders#commitorder'
  post "orders/addoptions" => 'orders#addoptions'
  get "orders/chooseoptions" => 'orders#chooseoptions'
  post "orders/addproducttoorder" => 'orders#addproducttoorder'
  get "orders/selectproduct" => 'orders#selectproduct'
  get "orders/pickup" => 'orders#pickup'
  get "orders/delivery" => 'orders#delivery'
  get "orders/oldorders" => 'orders#oldorders'
  get "orders/receipt" => 'orders#receipt'
  get "default/index" 
  post "orders/pickoptions" => 'orders#pickoptions'
  get "orders/cashout" => 'orders#cashout'
  get "orders/all" => 'orders#all'
  post "orders/cashedout" => 'orders#cashedout'
  post "orders/confirmorder" => 'orders#confirmorder'
  get "orders/custsearch" => 'orders#custsearch'
  get "orders/startorder" => 'orders#startorder'
  get "orders/pending" => 'orders#pending'
  get "orders/walkin" => 'orders#walkin'
  get "orders/selectcoupons" => 'orders#selectcoupons'
  post "orders/addcoupons" => 'orders#addcoupons'
  get "orders/recalcForOrderlineDelete" => 'orders#recalcForOrderlineDelete'
  
  resources :orders

  resources :orderlines
  
  # Route Signup to new users page
  get  '/signup',  to: 'users#new'

  # Route Logins to Sessions controller
  get    '/login',   to: 'sessions#new'
  post   '/login',   to: 'sessions#create'
  delete '/logout',  to: 'sessions#destroy'
  get 'logout', to: 'sessions#destroy'
end

