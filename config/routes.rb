Rails.application.routes.draw do
  devise_for :users, controllers: {
    registrations: 'users/registrations'
  }

  # Specify the scope for the confirm route
  devise_scope :user do
    get 'users/confirm', to: 'users/registrations#confirm'
  end

  # Defines the root path route ("/")
  root "users#index"
  get 'users/user_lists' , to: 'users#user_lists'
  get 'users/:id/change_password' , to: 'users#change_password'
  resources :users
  resources :admin
  get 'posts/confirm' , to: 'posts#confirm'
  get 'posts/id/edit/confirm' , to: 'posts#edit_confirm'
  get 'posts/csv' , to: 'posts#csv'
  resources :posts
end

