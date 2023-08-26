Rails.application.routes.draw do
  devise_for :users,  controllers: {
    omniauth_callbacks: 'users/omniauth_callbacks'
  }

  resources :posts 
  
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  # get 'home/index'
  # Defines the root path route ("/")
  root to: 'home#index'
end
