Rails.application.routes.draw do
  root "static_pages#home"
  get "about"   => "static_pages#about"
  get "signup"  => "users#new"
  resources :users
  namespace :admin do
    resources :users, except: [:create, :new, :show]
  end
end
