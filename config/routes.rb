Rails.application.routes.draw do
  get '/search' => "search#search"
  get 'stores/show'
  get 'store/store'
  get 'users/show'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  root "home#home"
  get "/signup" => "users#new"
  get "/login" => "users#login_form"
  get "/logout" => "users#logout"
  post "/login" => "users#login"
  
  get "/stores/review/:id" => "stores#review"
  get "/stores/store_photos/:id" => "stores#photos"
  get "/stores/store_waiting_waiting/:id" => "stores#waiting_time"
  get "/stores/store_microposts/:id" => "stores#microposts"

  resources :users
  resources :stores
  resources :microposts, only: [:create, :destroy]

end
