Rails.application.routes.draw do
  resources :movies, except: [:edit, :update]
  resources :sessions, except: [:index, :show, :edit, :update]
  resources :users

  root :to => 'movies#index'
end
