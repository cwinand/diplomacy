Rails.application.routes.draw do
  devise_for :users
  get '/profile', to: 'users#show'
  get '/users/:id', to: 'users#show'

  root 'users#show'
end
