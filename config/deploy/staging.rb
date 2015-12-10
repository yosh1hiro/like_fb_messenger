set :stage, :staging
set :branch, 'master'
set :rbenv_type, :user
set :rbenv_ruby, '2.2.3'
set :rails_env, 'staging'
set :unicorn_rack_env, 'staging'
set :bundle_without,  [:development, :test, :heroku_staging]

set :application_server_addrs, [
  '52.192.29.79'
]

set :db_server_addr, fetch(:application_server_addrs).first

fetch(:application_server_addrs).each do |server_addr|
  server server_addr, user: 'ubuntu', roles: %w(app web worker unicorn_roles)
end

server fetch(:db_server_addr), user: 'ubuntu', roles: %w(db web)
