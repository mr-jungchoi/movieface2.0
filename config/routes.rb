Rails.application.routes.draw do
  resources :movies, only: [:index, :create]
  resources :sessions, except: [:index, :show, :edit, :update]
  resources :users

  get '/movies/show' => 'movies#show'

  root :to => 'movies#index'
end
