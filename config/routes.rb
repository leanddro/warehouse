Rails.application.routes.draw do
  root 'home#index'

  resources :warehouses, only: %i(show new create edit update destroy)
  resources :suppliers, only: %i(index new create show edit update)
  resources :product_models, only: %i(index new create show)
end
