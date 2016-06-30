Rails.application.routes.draw do
  root "static_pages#home"
  get "about" => "static_pages#about"
  get "signup" => "users#new"
  namespace :admin do
    resources :users, except: [:create, :new, :show]
    resources :categories
  end
  resources :users do
    member do
      get "/:relationship_type",
      :to => "relationships#index",
      as: "follow"
    end
  end
  get "sessions/new"
  get    "login" => "sessions#new"
  post   "login" => "sessions#create"
  delete "logout" => "sessions#destroy"
  resources :relationships, only: [:create, :destroy]
end
