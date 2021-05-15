Rails.application.routes.draw do
  resources :categories
  devise_for :users
  root 'homes#index'

  resources :homes, only: [:index, :show]

  resources :orders, only: [:new, :create]

  namespace :admins do
    resources :products do 
      member do
        delete :delete_image
      end
    end
    resources :orders, only: [:index]
    namespace :products do
      post 'csv_upload'
    end
  end

 
  
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
