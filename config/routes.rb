Rails.application.routes.draw do
  devise_for :users, controllers: { confirmations: 'confirmations' }, sign_out_via: :get

  resources :games do
    member do
      get 'settings', to: :edit
      post 'invites', to: :create_invites
      get 'start', to: :start
    end
  end

  resources :orders

  get '/profile', to: 'users#show'
  get '/users/:id', to: 'users#show'

  patch '/users/:id/accept', to: 'users#accept_invite'
  patch '/users/:id/decline', to: 'users#decline_invite'

  root 'users#show'
end
