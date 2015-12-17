Rails.application.routes.draw do
  root to: "welcome#index"
  get "/auth/twitter", as: :login
  get "/auth/twitter/callback", to: "sessions#create"

  get "/dashboard", to: "dashboard#index"

  resources :tweets, only: [:new, :create]
  resources :replies, only: [:create]
  post "/replies/new", to: "replies#new", as: "new_reply"
  resources :favorites, only: [:create]
  resources :retweets, only: [:create]
end
