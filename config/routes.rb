Rails.application.routes.draw do
  devise_for :users
  root to: 'home#index'
  resources :items, only: [:show, :new, :create, :edit, :update]
  resources :lots, only: [:show, :new, :create]
end
