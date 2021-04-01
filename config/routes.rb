Rails.application.routes.draw do
  resources :categories
  devise_for :users
  resources :products
  root 'products#index'

  namespace :products do
    post 'csv_upload'
  end
  
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
