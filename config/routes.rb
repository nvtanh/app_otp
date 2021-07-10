Rails.application.routes.draw do
  root 'sessions#new'
  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'

  namespace :dashboard do
    root 'home#index'
  end
end
