Rails.application.routes.draw do
  root to: 'sessions#new'
  draw :admin
  draw :artist_module
  draw :api
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
