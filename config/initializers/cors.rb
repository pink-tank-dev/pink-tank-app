Rails.application.config.middleware.insert_before 0, Rack::Cors do
  if Rails.env.staging?
    allow do
      origins 'https://pink-tank-react-staging.herokuapp.com'
      resource '/api/*',
        headers: :any,
        methods: [:get, :post, :patch, :put]
    end
  end

  if Rails.env.production?
    allow do
      origins 'https://pink-tank-react-production.herokuapp.com'
      resource '/api/*',
        headers: :any,
        methods: [:get, :post, :patch, :put]
    end
  end
end
