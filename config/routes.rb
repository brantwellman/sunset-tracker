Rails.application.routes.draw do
  root "home#index"
  resources :locations, only: [:new, :show, :create, :update]
  get '/data', to: 'locations#data'
  post '/today', to: 'locations#today'
  get '/dashboard', to: 'users#show'

  get '/auth/twitter/callback', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'
end
