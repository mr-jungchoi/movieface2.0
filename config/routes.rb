Rails.application.routes.draw do

  resources :movies, except: [:edit, :update] do
    resources :reviews
    resources :favorites, except: [ :edit, :update]
  end
  resources :genres, only: [:index, :show]

  resources :sessions, except: [:index, :show, :edit, :update]
  resources :users


  root :to => 'genres#index'

end
