Rails.application.routes.draw do
  resources :friend_requests, only: [:create, :destroy]
  resources :friendships, only: [:create, :destroy]
  resources :users, only: [:create]
  resources :events, only: [:index, :create, :update, :destroy]
  post '/signup', to: 'users#create'
  post '/login', to: 'users#login'
  get '/current_user', to: 'users#show'
  get '/users/:id/events', to: 'users#events'
  get 'users/:id/friend_requests', to: 'users#friend_requests'
  get 'users/:id/friends', to: 'users#friends'
  get 'users/search/:q', to: 'users#search'
end
