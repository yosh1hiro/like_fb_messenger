set :application, 'fi_chat'
set :repo_url, 'git@github.com:FiNCDeveloper/fi_chat.git'

set :deploy_to, "/var/www/#{fetch(:application)}"

set :deploy_via, :remote_cache

set :linked_dirs, fetch(:linked_dirs, []).push('log', 'tmp/pids', 'tmp/cache', 'tmp/sockets', 'vendor/bundle', 'public/system')

# whenever
# set :whenever_identifier, ->{ "#{fetch(:application)}_#{fetch(:stage)}" }
# set :whenever_roles, :cron
# set :whenever_environment, "#{fetch(:stage)}"

set :unicorn_stop_sleep_time, 3

namespace :deploy do

  #after :migrate, 'db:seed'

  after :publishing, :stop_start_unicorn do
    on roles(:web) do
      # unix command execute status;
      # 0 : true
      # 1 : false
      is_old = capture(
        "/usr/bin/test /etc/.secret/env.yml -ot #{fetch(:deploy_to)}/shared/tmp/pids/unicorn.pid; echo $?"
      )
      if is_old == '0'
        info 'env.yml is old. restat unicorn.'
        invoke 'unicorn:restart'
      else
        info 'env.yml is new. stop and start(reload env.yml) unicorn.'
        invoke 'unicorn:stop'
        execute :sleep, fetch(:unicorn_stop_sleep_time)
        invoke 'unicorn:start'
      end
    end
  end

end
