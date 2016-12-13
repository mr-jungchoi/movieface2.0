Rails.application.routes.draw do

  resources :movies, except: [:edit, :update] do
    resources :reviews
  end
  resources :genres, only: [:index, :show]
  resources :sessions, except: [:index, :show, :edit, :update]
  resources :users

  root :to => 'genres#index'
end
