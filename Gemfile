source 'https://rubygems.org'

gem 'rails', '4.2.1'
gem 'bundler'

# Config
gem 'rails_config'

# Storage
gem 'pg'

# Cron jobs
gem 'sidekiq'

# Emails
gem 'mailjet'

# Authentication
gem 'devise'
# gem 'omniauth'
# gem 'omniauth-facebook'

# Responder
gem 'responders'

# Views
gem 'kaminari'
gem 'sorted-activerecord'
gem 'sorted-actionview'

# Templating
gem 'haml-rails'
gem 'simple_form'

# JS
gem 'coffee-rails'
gem 'uglifier'

# CSS
gem 'sass-rails'
gem 'bootstrap-sass'
gem 'bootstrap-sass-extras'
gem 'font-awesome-sass'

# Validators & formats
gem 'jc-validates_timeliness'
gem 'global_phone'

# Analytics
gem 'google-analytics-rails'

# Deploy
gem 'execjs'
gem 'capistrano'
gem 'capistrano-bundler'
gem 'capistrano-rails'
gem 'capistrano-rbenv'

group :development, :test do
  gem 'capistrano-sidekiq'
  gem 'rspec-rails'
  gem 'factory_girl_rails'
  gem 'dotenv-rails'
  gem 'sinatra', '>= 1.3.0', :require => nil
end

group :test do
  gem 'shoulda-matchers'
  gem 'cucumber-rails', require: false
  gem 'database_cleaner'
end

group :development do
  gem 'global_phone_dbgen'
  gem 'web-console', '~> 2.0'
  gem "bullet"
  gem 'brakeman', :require => false

  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring'
end