require 'bundler/capistrano'
require 'capistrano-unicorn'
# require 'sidekiq/capistrano'
require 'capistrano-resque'
require 'capistrano/shared_file'
require 'capistrano/nginx/tasks'
require 'whenever/capistrano'

set :application, 'newstab'
set :server_name, 'thenewstab.ru'
set :sudo_user, 'rails'
set :user, 'rails'
set :app_port, 80
set :repository, 'git@github.com:vtsvang/newstab-backend.git'
set :scm, :git
set :branch, 'master'
set :rais_env, 'production'
set :whenever_command, "bundle exec whenever"

set :deploy_to, '/var/u/apps/newstab'
set :deploy_via, :remote_cache
set :git_enable_submodules, 0
set :keep_releases, 3
set :use_sudo, false
set :unicorn_pid, '/tmp/unicorn_newstab.pid'
set :shared_files, %w(config/aws.yml config/backups.yml config/resque_auth.yml)

# Resque
role :resque_worker, "thenewstab.ru"
role :resque_scheduler, "thenewstab.ru"

set :workers, { "feed, post, dump_database" => 1 }

# Uncomment this line if your workers need access to the Rails environment:
set :resque_environment_task, true

role :web, "thenewstab.ru"                          # Your HTTP server, Apache/etc
role :app, "thenewstab.ru"                          # This may be the same as your `Web` server
role :db,  "thenewstab.ru", :primary => true # This is where Rails migrations will run

role :app, "thenewstab.ru"                          # This may be the same as your `Web` server
role :db,  "thenewstab.ru", :primary => true # This is where Rails migrations will run

default_run_options[:pty] = true
ssh_options[:forward_agent] = true
default_run_options[:shell] = '/bin/bash --login'
logger.level = Logger::MAX_LEVEL

# Symlinks
after "deploy", "deploy:shared_file:create_symlink"

# Nginx
after "deploy:setup", "nginx:setup", "nginx:reload"

# if you want to clean up old releases on each deploy uncomment this:
after "deploy:restart", "deploy:cleanup"

# Resque
after "deploy:restart", "resque:restart"

# if you're still using the script/reaper helper you will need
# these http://github.com/rails/irs_process_scripts

# Unicorn
after  "deploy:stop", "unicorn:stop"
after  "deploy:start",  "unicorn:start"
before "deploy:restart",  "unicorn:restart"

namespace :db do
  desc "Backup database"
  task :backup do
    run "cd #{deploy_to}/current; /usr/bin/env rake db:backup RAILS_ENV=#{rails_env}"
  end
end

namespace :deploy do
  desc "Run seeds.rb"
  task :seed do
    run("cd #{deploy_to}/current; /usr/bin/env rake db:seed RAILS_ENV=#{rails_env}")
  end
end

namespace :feeds do
  desc "Run feeds parse rake task"
  task :parse do
    run("cd #{deploy_to}/current; /usr/bin/env rake feeds:parse RAILS_ENV=#{rails_env}")
  end
end