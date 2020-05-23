Rails.application.routes.draw do

  devise_for :users, controllers: {
    sessions: 'users/sessions',
    passwords: 'users/passwords',
    registrations: 'users/registrations'
  }

  root to: 'home#index'
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  get '/home',      to: 'home#index'
  get '/help',      to: 'home#help'

  resources :users do
    member do
      get :following, :followers
    end
  end

  resources :users,         only: [:show, :index]
  resources :relationships, only: [:create, :destroy]
  resources :posts do
    resources :comments,    only: [:create, :destroy]
  end

  resources :posts do
    resources :likeposts
  end

end
