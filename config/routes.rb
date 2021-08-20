Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root to: "games#index"

  devise_for :users

  resources :critics
  resources :involved_companies
  resources :genres
  resources :platforms
  resources :games
  resources :companies
  resources :users
end
