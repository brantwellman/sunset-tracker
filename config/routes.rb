Rails.application.routes.draw do
  root "home#index"
  resources :locations, only: [:new, :show, :create]
  get '/dashboard', to: 'users#show'
  get '/data', to: 'users#forecast_data'

  get '/auth/twitter/callback', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'
end
