namespace :admin do
  resources :users, except: %i[destroy] do
    member do
      get 'edit_password'
      put 'update_password'
      put 'reset_password'
    end
  end
  resources :artists, except: %i[destroy] do
    member do
      put 'reset_password'
      put 'send_welcome_email'
    end
    resources :posts, only: %i[index show]
    resources :artworks, except: %i[index]
  end
  resources :exhibitions, except: %i[destroy] do
    resources :series, except: %i[index]
  end
end
