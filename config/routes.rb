Rails.application.routes.draw do
  get '/search' => "search#search"
  get 'stores/show'
  get 'store/store'
  get 'users/show'

  root "home#home"
  get "/users/likes/:id" => "users#likes", as: "user_likes"
  get "/users/miciroposts/:id" => "users#microposts", as: "user_microposts"
  get "/signup" => "users#new"
  get "/login" => "users#login_form"
  get "/logout" => "users#logout"
  post "/login" => "users#login"
  
  post "/microposts/review/:id" => "microposts#create"
  get "/microposts/review/:id" => "microposts#review", as: "microposts"
  
  post "/stores/like/:id" => "likes#create", as: "store_like"
  delete "/stores/like/:id" => "likes#destroy", as: "store_unlike"
  get "/stores/store_photos/:id" => "stores#photos", as: "store_photos"
  get "/stores/store_waiting_time/:id" => "stores#waiting_time", as: "store_waiting_time"
  get "/stores/store_microposts/:id" => "stores#microposts", as: "store_microposts"

  resources :users
  resources :stores
  resources :microposts,  only: [:show, :destroy]
end
