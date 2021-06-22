Rails.application.routes.draw do
  # gem 'rails_admin'
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  root to: 'homes#top'
  get 'homes/about'
  get 'homes/contact'

  # gem 'devise'
  devise_for :users

  get 'items/graph'
  resources :items
  resources :brands, only: [:index, :create, :edit, :update, :destroy]
  resources :users, only: [:update]
  get 'users/unsubscribe'
  patch 'users/withdraw'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
