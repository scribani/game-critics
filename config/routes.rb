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

  # Routes for devise
  devise_for :users, controllers: {
    omniauth_callbacks: "callbacks",
    registrations: "users/registrations",
    sessions: "users/sessions",
    passwords: "users/passwords"
  }

  resources :involved_companies
  resources :genres
  resources :platforms
  resources :games
  resources :companies
  resources :users

  get "/:criticable/:criticable_id/critics", to: "critics#index", as: :critics
  post "/:criticable/:criticable_id/critics", to: "critics#create"
  patch "/:criticable/:criticable_id/critics/:critic_id", to: "critics#update"
  delete "/:criticable/:criticable_id/critics/:critic_id", to: "critics#destroy"
end
