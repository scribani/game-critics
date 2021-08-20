Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root to: "games#index"

  # Routes for devise
  devise_for :users, controllers: {
    omniauth_callbacks: "callbacks",
    registrations: "users/registrations"
  }

  resources :critics
  resources :involved_companies
  resources :genres
  resources :platforms

  resources :games do
    resources :critics
  end
  resources :companies
  resources :users
end
