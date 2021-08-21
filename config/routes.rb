Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root to: "games#index"

  post "/games/:id/genres", to: "games#add_genre"
  post "/games/:id/platforms", to: "games#add_platform"

  # Routes for devise
  devise_for :users, controllers: {
    omniauth_callbacks: "callbacks",
    registrations: "users/registrations",
    sessions: 'users/sessions',
    passwords: 'users/passwords'
  }
  
  resources :critics
  resources :involved_companies
  resources :genres
  resources :platforms

  resources :games do
    resources :critics
  end

  resources :games do
    resources :genres
  end

  resources :games do
    resources :platforms
  end

  resources :companies
  resources :users
end
