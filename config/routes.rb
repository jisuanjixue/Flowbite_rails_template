# == Route Map
#

Rails.application.routes.draw do
  devise_for :users,  controllers: {
    omniauth_callbacks: 'users/omniauth_callbacks'
  }

  resources :after_signup

  resources :posts do
    resources :comments
  end
  
  resources :tables
  
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  # get 'home/index'
  # Defines the root path route ("/")
  root to: 'home#index'
end
