require "sidekiq/web"

mount Sidekiq::Web => "/sidekiq"
