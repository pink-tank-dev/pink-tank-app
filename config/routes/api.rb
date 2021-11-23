namespace :api do
  namespace :v1, defaults: { format: :json } do
    post 'contact_us', to: 'contact_us#create'
    resources :artists, only: %i[index show]
    resource :gallery, only: :show do
      collection do
        get :artwork
      end
    end
  end

  namespace :metaverse, defaults: { format: :json } do
    resources :artists, only: %i[show]
    resources :visitors, only: %i[create] do
      collection do
        post :thank_you
      end
    end
  end
end
