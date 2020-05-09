Rails.application.routes.draw do

  devise_for :users, controllers: {
    sessions: 'users/sessions',
    passwords: 'users/passwords',
    registrations: 'users/registrations'
  }

  #get 'users/index'
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
    resources :comments,            only: [:create, :destroy]
  end
  resources :posts,         only: [:create, :destroy, :show]
  resources :posts do
    resources :likeposts
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
