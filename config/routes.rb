Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  resources :users, only: [:create]
  resources :events, only: [:index,:create]
  post '/auth', to: 'users#create'
end
