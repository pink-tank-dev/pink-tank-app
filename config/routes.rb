Rails.application.routes.draw do
  root to: 'sessions#new'
  post 'login', to: 'sessions#create'
  delete 'logout', to: 'sessions#destroy'
  get 'dashboard', to: 'dashboard#show'
  resources :users, except: %i[destroy] do
    member do
      get 'edit_password'
      put 'update_password'
    end
  end
  resources :artists, except: %i[destroy]

  draw :api
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
