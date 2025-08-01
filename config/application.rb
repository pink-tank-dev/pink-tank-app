require_relative "boot"

require "rails/all"

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module PinkTankApp
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 6.1
    config.session_store :cookie_store, expire_after: 1.hour
    config.generators do |g|
      g.helper false
      g.assets false
      g.view_specs false
      g.factory_bot false
    end
    config.time_zone = 'Asia/Kuala_Lumpur'
    config.beginning_of_the_week = :sunday
    config.i18n.default_locale = :en
    config.active_storage.variant_processor = :mini_magick

    # Configuration for the application, engines, and railties goes here.
    #
    # These settings can be overridden in specific environments using the files
    # in config/environments, which are processed later.
    #
    # config.eager_load_paths << Rails.root.join("extras")
  end
end
