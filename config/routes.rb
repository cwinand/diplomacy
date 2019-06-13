Rails.application.routes.draw do
  resources :games
  devise_for :users, controllers: { confirmations: 'confirmations' }, sign_out_via: :get

  get '/profile', to: 'users#show'
  get '/users/:id', to: 'users#show'

  patch '/users/:id/accept', to: 'users#accept_invite'
  patch '/users/:id/decline', to: 'users#decline_invite'

  root 'users#show'
end
