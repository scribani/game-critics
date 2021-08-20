Rails.application.routes.draw do
  devise_for :users
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root to: "home#index"

  resources :involved_companies
  resources :genres
  resources :platforms

  resources :games do
    resources :critics
  end
  resources :companies
  resources :users
end
