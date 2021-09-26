Rails.application.routes.draw do
  root to: 'sessions#new'
  post 'login_user', to: 'sessions#login_user'
  delete 'logout_user', to: 'sessions#logout_user'
  post 'login_artist', to: 'sessions#login_artist'
  delete 'logout_artist', to: 'sessions#logout_artist'
  resource :embed, only: %i[update]
  resources :artworks, only: %i[index] do
    member do
      put :move
    end
  end
  draw :admin
  draw :artist_module
  draw :api
  draw :sidekiq
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
