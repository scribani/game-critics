Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root to: "games#index"

  post "/games/:id/genres", to: "games#add_genre", as: :add_genres
  post "/games/:id/platforms", to: "games#add_platform", as: :add_platforms
  post "/games/:id/developer", to: "games#add_developer"
  post "/games/:id/publisher", to: "games#add_publisher"

  delete "games/:id/publisher/:id", to: "games#remove_publisher", as: :remove_publisher
  delete "games/:id/developer/:id", to: "games#remove_developer", as: :remove_developer
  delete "games/:id/platform/:id", to: "games#remove_platform", as: :remove_platform
  delete "games/:id/genre/:id", to: "games#remove_genre", as: :remove_genre

  resources :remove_publisher, :remove_developer, :remove_platform, :remove_genre

  # probar si es necesario
  resources :games do
    resources :involved_companies
  end

  # Routes for devise
  devise_for :users, controllers: {
    omniauth_callbacks: "callbacks",
    registrations: "users/registrations",
    sessions: "users/sessions",
    passwords: "users/passwords"
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
