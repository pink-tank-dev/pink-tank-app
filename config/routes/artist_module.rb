namespace :artist do
  post 'login', to: 'sessions#create'
  delete 'logout', to: 'sessions#destroy'
  resources :posts
end
