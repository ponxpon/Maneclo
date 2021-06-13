Rails.application.routes.draw do
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  root to: 'homes#top'
  get 'homes/about'
  get 'homes/contact'

  devise_for :users

  get 'items/graph'
  resources :items
  resources :brands, only: [:index, :create, :edit, :update, :destroy]
  resources :categories, only: [:index, :create, :update]
  resources :users, only: [:index, :update]
  get 'users/unsubscribe'
  patch 'users/withdraw'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
