Rails.application.routes.draw do
  resources :orders
  resources :games
  resources :genres
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  root to: "home#index"
end
