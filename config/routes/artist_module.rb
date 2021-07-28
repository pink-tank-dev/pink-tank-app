namespace :artist_module, path: 'artist' do
  post 'login', to: 'sessions#create'
  delete 'logout', to: 'sessions#destroy'
  resource :profile, except: %i[new create destroy] do
    collection do
      get 'edit_password'
      put 'update_password'
    end
  end
  resources :posts, except: %i[index destroy]
end
