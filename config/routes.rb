Rails.application.routes.draw do
  devise_for :users
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  resources :orders
  resources :games
  resources :genres
  resources :cart do
    post "increment"
    post "decrement"
  end
  resources :checkout

  root to: "home#index"
end
