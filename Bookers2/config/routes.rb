Rails.application.routes.draw do
  devise_for :users
  root to: 'home#index'
  match 'home/about' => 'home#about', via: 'get'
  get 'books/:id/edit' => 'books#edit'
  get 'users/:id/edit' => 'users#edit'
  get 'users/:id' => 'users#show', as: :mypage
  patch 'books/:id' => 'books#update', as: 'update_books'
  patch 'users/:id' => 'users#update', as: 'update_users'

  resources :books, only: [:create, :index, :edit, :show, :destroy, :update]
  resources :users, only: [:index, :show, :edit]
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
