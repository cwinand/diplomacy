Rails.application.routes.draw do
  resources :games
  devise_for :users, controllers: { confirmations: 'confirmations' }, sign_out_via: :get

  get '/profile', to: 'users#show'
  get '/users/:id', to: 'users#show'

  root 'users#show'
end
