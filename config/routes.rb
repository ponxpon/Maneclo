Rails.application.routes.draw do
  get 'categories/index'
  get 'brands/index'
  get 'items/index'
  get 'items/new'
  get 'items/show'
  get 'items/edit'
  get 'items/graph'
  get 'users/index'
  get 'users/unsubscribe'
  get 'homes/top'
  get 'homes/about'
  get 'homes/contact'
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
