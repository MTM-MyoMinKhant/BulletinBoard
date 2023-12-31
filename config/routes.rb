Rails.application.routes.draw do
  devise_for :users

  # Defines the root path route ("/")
  root "posts#index"
  
  resources :users do
    collection do
      get 'users/user_lists' , to: 'users#user_lists'
      get 'users/confirm' , to: 'users#confirm'
      post 'users/confirm_post' , to: 'users#confirm_post'
      delete 'users/soft_destroy' , to: 'users#soft_delete' , as: 'user_soft_delete'
    end

    member do
      get 'users/:id/change_password' , to: 'users#change_password' , as: 'user_change_password'
      put 'users/:id/password_update' , to: 'users#password_update' , as: 'user_password_update'
      post 'account/:id/create' , to: 'users#acc_create' , as: "user_account_create"
    end
  end

  resources :posts do
    collection do
      get 'posts/confirm' , to: 'posts#confirm'
      post 'posts/confirm_post' , to: 'posts#confirm_post'
      get 'posts/csv', to: 'posts#csv'
      post 'posts/csv/upload' , to: 'posts#csv_upload'
      delete 'posts/soft_destroy' , to: 'posts#soft_delete' , as: 'post_soft_delete'
    end
    member do
      get 'posts/:id/edit/confirm' , to: 'posts#edit_confirm' , as: 'edit_confirm'
      post 'posts/:id/edit/comfirm_post', to: 'posts#edit_confirm_post', as: 'confirm_post'
      put 'posts/:id/update' , to: 'posts#update' , as: 'post_update' 
    end
  end
end

