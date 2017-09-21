Rails.application.routes.draw do
  root 'pages#hello'

  resources :users
  get '/signup', to: 'users#new'
  post '/auth_code', to: 'users#auth_code'


end
