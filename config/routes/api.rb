namespace :api do
  namespace :v1, defaults: { format: :json } do
    post 'contact_us', to: 'contact_us#create'
    resources :artists, only: %i[index show]
  end

  namespace :metaverse, defaults: { format: :json } do
    resources :artists, only: %i[show]
  end
end
