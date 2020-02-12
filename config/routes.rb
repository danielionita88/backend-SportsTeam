Rails.application.routes.draw do
  resources :friend_requests, only: [:index, :create, :update, :destroy]
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  resources :users, only: [:create]
  resources :events, only: [:index, :create, :update, :destroy]
  post '/signup', to: 'users#create'
  post '/login', to: 'users#login'
  get '/current_user', to: 'users#show'
  get '/users/:id/events', to: 'users#events'
  get 'users/search/:q', to: 'users#search'
end
