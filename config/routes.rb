# == Route Map
#

Rails.application.routes.draw do
  get 'search/index'
  resources :categories
  authenticated :user, ->(user) { user.admin? } do
    get 'admin', to: 'admin#index'
    get 'admin/posts'
    get 'admin/comments'
    get 'admin/users'
    get 'admin/post/:id', to: 'admin#show_post', as: 'admin_post'
  end
  devise_for :users,  controllers: {
    omniauth_callbacks: 'users/omniauth_callbacks',
    registrations: 'users/registrations'
  }

  get 'search', to: 'search#index'

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
