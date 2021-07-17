namespace :artist_module, path: 'artist' do
  post 'login', to: 'sessions#create'
  delete 'logout', to: 'sessions#destroy'
  resource :profile, except: %i[new create destroy]
  resources :posts, except: %i[index destroy]
end
