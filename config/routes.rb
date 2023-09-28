Rails.application.routes.draw do
  # get 'words/create'
  # get 'words/destroy'
  # get 'word_books/index'
  devise_for :users,  controllers: {
    omniauth_callbacks: 'users/omniauth_callbacks'
  }

  resources :word_books do
    resources :words do
      patch 'mastered', on: :member      
      patch 'unmastered', on: :member
    end
  end  

  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  # get 'home/index'
  # Defines the root path route ("/")
  root to: 'word_books#index'
end
