Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check
  get "index/" , to: "admins#index" , as: "admin_index"
  get "show_request/" , to: "admins#show_request" , as: "show_request"
  get "owners/" , to: "admins#show_owner" , as: "owners"
  match "request_update(/:id)" , to: "admins#request_update" , as: "request_update", via: [:get, :patch , :put]
  get "show_update_request/" , to: "admins#show_update_request" , as: "show_update_request"
  delete "delete_request/:id" , to: "admins#delete_request" , as: "delete_request"
  delete "delete_owner/:id" , to: "admins#delete_owner" , as: "delete_owner"
  

  match '/logout(/:id)', to: "sessions#destroy", as: "user_logout", via: [:get, :delete]
  get "new_signup/" , to: "sessions#new_signup" , as: "new_signup"
  post "user_signup/" , to: "sessions#user_signup" , as: "user_signup"
  get "login/" , to: "sessions#new_login" , as: "login"
  post "login/" , to: "sessions#user_login" , as: "user_login"
  get "new_owner/" , to: "sessions#new_owner" , as: "new_owner"
  match "create_owner/" , to: "sessions#create_owner" , as: "create_owner" , via: [:patch,:post]


  get "owner_index/" , to: "owners#index" , as: "owner_index"
  get "addrestaurant/" , to: "owners#addrestaurant" , as: "addrestaurant"
  post "add_r/" , to: "owners#add_r" , as: "add_r"
  get "showrestaurant/" , to: "owners#showrestaurant" , as: "show_restaurant"
  get "add_staff/" , to: "owners#add_staff" , as: "add_staff"
  post "add_s/" , to: "owners#add_s" , as: "add_s"
  get "add_item/" , to: "owners#add_item" , as: "add_item"
  post "add_i/" , to: "owners#add_i" , as: "add_i"
  get "show_staff/" , to: "owners#showstaff" , as: "show_staff"
  get "show_item/" , to: "owners#show_item" , as: "show_item"
  delete "delete_staff/:id" , to: "owners#delete_staff" , as: "delete_staff"
  delete "delete_item/:id" , to: "owners#delete_item" , as: "delete_item"
  get "pending_orders/" , to: "owners#pending_orders" , as: "pending_orders"
  get "delivered_order/" , to: "owners#delivered_order" , as: "delivered_orders"
  match "order_update(/:id)" , to: "owners#order_update" , as: "order_update", via: [:get, :patch , :put]

  
  get "customers_index/" , to: "customers#index" , as: "customers_index"
  get "show_all_restaurant/" , to: "customers#show_all_restaurant" , as: "show_all_restaurant"
  get 'items/:id', to: 'customers#show_items', as: 'items_restaurant'
  get 'generate_invoice/:item_id', to: 'customers#generate_invoice', as: 'generate_invoice'

  
  get "send_new_request/" , to: "ownerdetails#send_new_request" , as: "send_new_request"
  post "send_request/" , to: "ownerdetails#send_request" , as: "send_request"


  match 'new_order/:item_id', to: 'orders#new_order', as: 'new_order', via: [:get, :post]
  post 'create_order', to: 'orders#create_order', as: 'create_order'
  get 'order_history', to: 'orders#order_history', as: 'order_history'
  
  # Defines the root path route ("/")
  root "sessions#index"
end
