namespace :api do
  namespace :v1, defaults: { format: :json } do
    post 'contact_us', to: 'contact_us#create'
  end
end
