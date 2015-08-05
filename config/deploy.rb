set :application, Settings.app_name
set :repo_url, 'git@github.com:....git'

set :deploy_to, "/home/deploy/apps/#{Settings.app_name.underscore}"

set :linked_files, %w{config/settings.yml config/sidekiq.yml}

# Do not include bin! https://github.com/capistrano/bundler/issues/45
set :linked_dirs, %w{log tmp/pids tmp/cache tmp/sockets vendor/bundle public/system}

set :bundle_binstubs, nil

namespace :deploy do

  desc 'Restart application'
  task :restart do
    on roles(:app), in: :sequence, wait: 5 do
      execute :touch, release_path.join('tmp/restart.txt')
    end
  end

  after :publishing, 'deploy:restart'
  after :finishing, 'deploy:cleanup'
end
