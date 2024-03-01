Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check
  get "index/" , to: "admins#index" , as: "index"
  # get "login/" , to: "admins#new_login" , as: "login"
  # post "login/" , to: "admins#admin_login" , as: "admin_login"
  get "owners/" , to: "admins#show" , as: "owners"
  match '/logout(/:id)', to: "sessions#destroy", as: "user_logout", via: [:get, :delete]

  get "new_signup/" , to: "sessions#new_signup" , as: "new_signup"
  post "user_signup/" , to: "sessions#user_signup" , as: "user_signup"
  get "login/" , to: "sessions#new_login" , as: "login"
  post "login/" , to: "sessions#user_login" , as: "user_login"

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

  get "customers_index/" , to: "customers#index" , as: "customers_index"

  
  # Defines the root path route ("/")
  root "sessions#index"
end
