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


  resources :users, :only => [:show, :index]
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
