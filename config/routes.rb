Rails.application.routes.draw do

  root to: 'links#index'
  
  resources :users, only: [:new, :create]
  resources :links, only: [:index]

  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'

end
