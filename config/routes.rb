Rails.application.routes.draw do
  # devise_for :users, controllers: {
  #   registrations: 'users/registrations'
  # }

  # Specify the scope for the confirm route
  # devise_scope :user do
  #   get 'users/confirm', to: 'users/registrations#confirm'
  # end

  # Defines the root path route ("/")
  root "users#index"
  get 'users/user_lists' , to: 'users#user_lists'
  get 'users/:id/change_password' , to: 'users#change_password'
  get 'users/confirm' , to: 'users#confirm'
  post 'users/confirm_post' , to: 'users#confirm_post'
  resources :users
  resources :admin
  get 'posts/confirm' , to: 'posts#confirm'
  post 'posts/confirm_post' , to: 'posts#confirm_post'
  get 'posts/:id/edit/confirm' , to: 'posts#edit_confirm' , as: 'edit_confirm'
  post 'posts/:id/edit/comfirm_post', to: 'posts#edit_confirm_post', as: 'confirm_post'
  get 'posts/csv' , to: 'posts#csv'
  put 'posts/:id/update' , to: 'posts#update' , as: 'post_update'
  resources :posts
end

