namespace :artist_module, path: 'artist' do
  resource :profile, except: %i[new create destroy] do
    collection do
      get 'edit_password'
      put 'update_password'
    end
  end
  resources :posts, except: %i[index destroy]
end
