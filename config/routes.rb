Rails.application.routes.draw do
  get '/search' => "search#search"
  get 'stores/show'
  get 'store/store'
  get 'users/show'

  root "home#home"
  get "/signup" => "users#new"
  get "/login" => "users#login_form"
  get "/logout" => "users#logout"
  post "/login" => "users#login"
  
  post "/microposts/review/:id" => "microposts#create"
  get "/microposts/review/:id" => "microposts#review", as: "microposts"
  get "/microposts/:id" => "microposts#show"
  
  get "/stores/store_photos/:id" => "stores#photos"
  get "/stores/store_waiting_waiting/:id" => "stores#waiting_time"
  get "/stores/store_microposts/:id" => "stores#microposts", as: "store_microposts"

  resources :users
  resources :stores

end
