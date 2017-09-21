Rails.application.routes.draw do
  get 'sessions/create'

  root 'pages#hello'

  resources :users
  get '/signup', to: 'users#new'
  post '/auth_code', to: 'users#auth_code'

  resources :sessions
  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'


end
