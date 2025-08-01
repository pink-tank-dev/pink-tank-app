source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '3.0.2'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails', branch: 'main'
gem 'rails', '~> 6.1.3', '>= 6.1.3.2'
# Use sqlite3 as the database for Active Record
gem 'pg', '~> 1.2', '>= 1.2.3'
# Use Puma as the app server
gem 'puma', '~> 5.0'
# Use SCSS for stylesheets
gem 'sass-rails', '>= 6'
# Transpile app-like JavaScript. Read more: https://github.com/rails/webpacker
gem 'webpacker', '~> 5.0'
# Turbolinks makes navigating your web application faster. Read more: https://github.com/turbolinks/turbolinks
gem 'turbolinks', '~> 5'
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 2.7'
# Use Redis adapter to run Action Cable in production
# gem 'redis', '~> 4.0'
# Use Active Model has_secure_password
gem 'bcrypt', '~> 3.1.7'

# Use Active Storage variant
gem 'image_processing', '~> 1.12', '>= 1.12.1'
gem 'mini_magick', '~> 4.11'

# Reduces boot times through caching; required in config/boot.rb
gem 'actionpack-action_caching', '~> 1.2', '>= 1.2.2'
gem "acts_as_list", "~> 1.0"
gem 'aws-sdk-s3', require: false
gem 'bootsnap', '>= 1.4.4', require: false
gem 'cocoon', '~> 1.2', '>= 1.2.15'
gem 'config', '~> 3.1'
gem 'dalli', '~> 2.7', '>= 2.7.11'
gem 'faker', '~> 2.18'
gem 'friendly_id', '~> 5.4.0'
gem 'google-apis-core', '~> 0.4.1'
gem 'google-apis-drive_v3', '~> 0.15.0'
gem 'google-apis-sheets_v4', '~> 0.10.0'
gem 'google-apis-oauth2_v2', '~> 0.6.0'
gem 'jwt', '~> 2.2', '>= 2.2.3'
gem 'kaminari', '~> 1.2', '>= 1.2.1'
gem 'bootstrap5-kaminari-views', '~> 0.0.1'
gem 'MailchimpTransactional', '~> 1.0', '>= 1.0.46'
gem 'money-rails', '~> 1.7'
gem 'rack-cors', '~> 1.1', '>= 1.1.1'
gem 'redis-namespace', '~> 1.8', '>= 1.8.1'
gem 'receipts', '~> 1.1', '>= 1.1.2'
gem 'sentry-ruby', '~> 4.6', '>= 4.6.4'
gem 'sentry-rails', '~> 4.6', '>= 4.6.4'
gem 'sidekiq', '~> 6.2', '>= 6.2.1'
gem 'uglifier', '~> 4.2'

group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug', platforms: %i[mri mingw x64_mingw]
  gem 'factory_bot_rails'
  gem 'rexml', '~> 3.2', '>= 3.2.4'
  gem 'rspec-rails', '~> 5.0', '>= 5.0.1'
end

group :development do
  gem 'annotate'
  gem 'listen', '~> 3.3'
  # Display performance information such as SQL time and flame graphs for each request in your browser.
  # Can be configured to work on production as well see: https://github.com/MiniProfiler/rack-mini-profiler/blob/master/README.md
  gem 'rack-mini-profiler', '~> 2.0'
  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring'
  # Access an interactive console on exception pages or by calling 'console' anywhere in the code.
  gem 'web-console', '>= 4.1.0'
end

group :test do
  # Adds support for Capybara system testing and selenium driver
  gem 'capybara', '>= 3.26'
  gem 'selenium-webdriver'
  # Easy installation and use of web drivers to run system tests with browsers
  gem 'shoulda-matchers', '~> 4.0'
  gem 'webdrivers'
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: %i[mingw mswin x64_mingw jruby]
