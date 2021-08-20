Rails.application.routes.draw do
  root to: "companies#index"
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  resources :critics
  resources :involved_companies
  resources :genres
  resources :platforms
  resources :games
  resources :companies
  resources :users
end
