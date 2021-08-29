Rails.application.routes.draw do
  get 'stores/show'
  get 'store/store'
  get 'users/show'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  root "home#home"
  get "/signup" => "users#new"
  get "/login" => "users#login_form"
  get "/logout" => "users#logout"
  post "/login" => "users#login"
  resources :users
  resources :stores

end
