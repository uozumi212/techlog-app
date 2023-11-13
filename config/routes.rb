Rails.application.routes.draw do
  # get 'posts/new'
  devise_for :users
  root 'home#top'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  resources :posts, only: [:index, :new, :create, :show, :destroy]
end
