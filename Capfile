# Load DSL and set up stages
require 'capistrano/setup'

# Include default deployment tasks
require 'capistrano/deploy'

require 'capistrano/bundler'
require 'capistrano/rails'

require 'capistrano/sidekiq'
# require 'capistrano/sidekiq/monit' # buggy: https://github.com/seuros/capistrano-sidekiq/issues/49 
set :pty,  false
set :sidekiq_config, -> { File.join(shared_path, 'config', 'sidekiq.yml') }

# If you are using rbenv add these lines:
require 'capistrano/rbenv'
set :rbenv_type, :user # or :system, depends on your rbenv setup
set :rbenv_ruby, '2.2.1'
