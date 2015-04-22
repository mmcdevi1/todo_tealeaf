Rails.application.routes.draw do
  
  get 'pages/front'

  root to: "pages#front"
  resources :todos

  resources :users, only: [:index, :edit, :show]

  resources :sessions, only: [:create]
  get 'logout', to: "sessions#destroy"

  resources :relationships, only: [:index, :create, :destroy]
end
