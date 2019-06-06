Rails.application.routes.draw do
  devise_for :users, controllers: { confirmations: 'confirmations' }
  get '/profile', to: 'users#show'
  get '/users/:id', to: 'users#show'

  root 'users#show'
end
