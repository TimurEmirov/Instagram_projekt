Rails.application.routes.draw do
  root to: 'home#index'
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  get '/home', to: 'home#index'
  get '/help', to: 'home#help'
  devise_for :users, controllers: {
    sessions: 'users/sessions',
    passwords: 'users/passwords',
    registrations: 'users/registrations'
}
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
