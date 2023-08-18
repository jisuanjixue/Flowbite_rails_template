Rails.application.routes.draw do
  resources :posts
  devise_for :users,  controllers: {
    omniauth_callbacks: 'users/omniauth_callbacks'
  }
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  # get 'home/index'
  # Defines the root path route ("/")
  root to: 'home#index'
end
