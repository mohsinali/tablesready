#require 'bundler/capistrano'
# config valid only for current version of Capistrano
lock "3.8.1"

set :application, "tablesready"
set :repo_url, "https://github.com/mohsinali/tablesready.git"

# Default branch is :master
# ask :branch, `git rev-parse --abbrev-ref HEAD`.chomp

# Default deploy_to directory is /var/www/my_app_name
 set :deploy_to, "/var/www/html/cap"
 append :linked_files, "config/database.yml", "config/secrets.yml" , "config/application.yml"
 append :linked_dirs, "log", "tmp/pids", "tmp/cache", "tmp/sockets", "vendor/bundle", "public/system", "public/uploads"


# Capistrano Delayed Job
set :delayed_job_server_role, :worker
set :delayed_job_args, "-n 2"
# Default value for :format is :airbrussh.
# set :format, :airbrussh

# You can configure the Airbrussh format using :format_options.
# These are the defaults.
# set :format_options, command_output: true, log_file: "log/capistrano.log", color: :auto, truncate: :auto

# Default value for :pty is false
# set :pty, true

# Default value for :linked_files is []
# append :linked_files, "config/database.yml", "config/secrets.yml"

# Default value for linked_dirs is []
# append :linked_dirs, "log", "tmp/pids", "tmp/cache", "tmp/sockets", "public/system"

# Default value for default_env is {}
# set :default_env, { path: "/opt/ruby/bin:$PATH" }

# Default value for keep_releases is 5
# set :keep_releases, 5
#namespace :deploy do
  # ....
  # @example
  #   bundle exec cap uat deploy:invoke task=users:update_defaults
#  desc 'Run Custom Bundler'
#  task :invoke do
#    fail 'no task provided' unless ENV['task']
#
#    on roles(:app) do
#      within release_path do
#        with rails_env: fetch(:rails_env) do
#          execute :bundle:install --path vendor/cache,ENV['task']
#        end
#      end
#    end
 # end

#end
after 'deploy:publishing', 'deploy:restart'
namespace :deploy do
  task :restart do
    invoke 'delayed_job:restart'
  end
end
