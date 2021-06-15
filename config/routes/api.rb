namespace :api do
  namespace :v1, defaults: { format: :json } do
    post 'contact_us', to: 'contact_us#create'
    resources :artists, except: %i[destroy]
  end
end
