Rails.application.routes.draw do
  root "home#index"

  resources :locations, only: [:new]

  get '/auth/twitter/callback', to: 'sessions#create'
end
