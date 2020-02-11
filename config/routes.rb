Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  resources :users, only: [:create]
  resources :events, only: [:index, :create, :destroy]
  post '/signup', to: 'users#create'
  post '/login', to: 'users#login'
  get '/current_user', to: 'users#show'
  get '/users/:id/events', to: 'users#events'
end
