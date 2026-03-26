Rails.application.routes.draw do
  # ActiveAdmin (ONLY ONCE)
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)

  # User Devise
  devise_for :users

  # Resources
  resources :users
  resources :products
  resources :categories
  resources :subcategories
  resources :carts, only: [:show]
  resources :cart_items, only: [:create, :destroy]
  resource :wishlist, only: [:show] do
    resources :wishlist_items, only: [:create, :destroy]
  end


  # Root path
  root "users#index"

  # Health check
  get "up" => "rails/health#show", as: :rails_health_check
end