namespace :admin do
  post 'login', to: 'sessions#create'
  delete 'logout', to: 'sessions#destroy'
  resources :users, except: %i[destroy] do
    member do
      get 'edit_password'
      put 'update_password'
    end
  end
  resources :artists, except: %i[destroy] do
    resources :posts, except: %i[destroy]
  end  
end
