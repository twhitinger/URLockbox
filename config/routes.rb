Rails.application.routes.draw do

  root to: 'connections#index'
  resources :users, only: [:new, :create]
  resources :connections, only: [:index]

  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'

end
