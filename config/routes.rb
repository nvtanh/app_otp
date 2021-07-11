Rails.application.routes.draw do
  root 'sessions#new'

  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'

  namespace :dashboard do
    root 'home#index'

    resources :beneficiaries do
      resources :transactions, only: [:new, :create]
    end
  end
end
