Ratebeer::Application.routes.draw do
  resources :styles

  resources :memberships

  resources :beer_clubs

  resources :users

  resources :beers

  resources :breweries

  resources :ratings, :only => [:index, :new, :create, :destroy]

  resources :sessions, :only => [:new, :create, :destroy]
resources :breweries do
    post 'toggle_activity', on: :member
  end
get 'brewerylist', to:'breweries#brewlist'
get 'ngbeerlist', to:'beers#nglist'
  get 'beerlist', to:'beers#list'
  get 'signup', to: 'users#new'
  get 'signin', to: 'sessions#new'
  delete 'signout', to: 'sessions#destroy'

  resources :places, only:[:index, :show]
  post 'places', to:'places#search'

  root 'breweries#index'

end
