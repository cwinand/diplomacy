Rails.application.routes.draw do
  devise_for :users, controllers: { confirmations: 'confirmations' }, sign_out_via: :get

  resources :games
  get '/games/:id/settings', to: 'game#edit'

  get '/profile', to: 'users#show'
  get '/users/:id', to: 'users#show'

  patch '/users/:id/accept', to: 'users#accept_invite'
  patch '/users/:id/decline', to: 'users#decline_invite'

  root 'users#show'
end
