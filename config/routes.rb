Rails.application.routes.draw do
  get 'words/create'
  get 'words/destroy'
  get 'word_books/index'
  devise_for :users,  controllers: {
    omniauth_callbacks: 'users/omniauth_callbacks'
  }

  resources :users do
    resources :wordbooks, shallow: true do
      resources :words
    end
  end

  resources :words, only: [] do
    resources :word_statuses, only: [:create, :update]
  end
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  # get 'home/index'
  # Defines the root path route ("/")
  root to: 'home#index'
end
