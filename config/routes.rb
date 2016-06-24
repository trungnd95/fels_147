Rails.application.routes.draw do
  root "static_pages#home"
  get "about"   => "static_pages#about"
  get "signup"  => "users#new"
  resources :users
  namespace :admin do
    resources :users, except: [:create, :new, :show]
  end
  get "sessions/new"
  get    "login"  =>  "sessions#new"
  post   "login"  =>  "sessions#create"
  delete "logout" =>  "sessions#destroy"
end
