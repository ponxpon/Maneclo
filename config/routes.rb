Rails.application.routes.draw do
  root to: 'homes#top'
  get 'homes/about'
  get 'homes/contact'
  
  devise_for :users
  
  resources :items
  get 'items/graph'
  resources :brands, only: [:index, :create, :update]
  resources :categories, only: [:index, :create, :update]
  resources :users, only: [:index, :update]
  get 'users/unsubscribe'
  patch 'users/withdraw'
  
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
