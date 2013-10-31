require 'bundler/capistrano'

set :application, 'newstab'
set :user, 'rails'
set :repository, 'git@github.com:vtsvang/newstab-backend.git'
set :scm, :git
set :branch, 'master'
set :rais_env, 'production'

set :deploy_to, '/var/u/apps/newstab'
set :deploy_via, :remote_cache
set :git_enable_submodules, 0
set :keep_releases, 3
set :use_sudo, false

role :web, "146.185.159.31"                          # Your HTTP server, Apache/etc
role :app, "146.185.159.31"                          # This may be the same as your `Web` server
role :db,  "146.185.159.31", :primary => true # This is where Rails migrations will run


role :app, "146.185.159.31"                          # This may be the same as your `Web` server
role :db,  "146.185.159.31", :primary => true # This is where Rails migrations will run

default_run_options[:pty] = true
ssh_options[:forward_agent] = true
default_run_options[:shell] = '/bin/bash --login'

# if you want to clean up old releases on each deploy uncomment this:
after "deploy:restart", "deploy:cleanup"

# if you're still using the script/reaper helper you will need
# these http://github.com/rails/irs_process_scripts

# If you are using Passenger mod_rails uncomment this:
# namespace :deploy do
#   task :start do ; end
#   task :stop do ; end
#   task :restart, :roles => :app, :except => { :no_release => true } do
#     run "#{try_sudo} touch #{File.join(current_path,'tmp','restart.txt')}"
#   end
# end