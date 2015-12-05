source 'https://rubygems.org'

ruby '2.2.3'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '4.2.5'
# Use mysql as the database for Active Record
gem 'mysql2', '>= 0.3.13', '< 0.5'
# Use SCSS for stylesheets
gem 'sass-rails', '~> 5.0'
# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'
# Use CoffeeScript for .coffee assets and views
gem 'coffee-rails', '~> 4.1.0'
# See https://github.com/rails/execjs#readme for more supported runtimes
gem 'therubyracer', platforms: :ruby

# Use jquery as the JavaScript library
gem 'jquery-rails'
# Turbolinks makes following links in your web application faster. Read more: https://github.com/rails/turbolinks
gem 'turbolinks'
# bundle exec rake doc:rails generates the API under doc/api.
gem 'sdoc', '~> 0.4.0', group: :doc

# Use ActiveModel has_secure_password
# gem 'bcrypt', '~> 3.1.7'

# Use Unicorn as the app server
gem 'unicorn'

# Use Capistrano for deployment
# gem 'capistrano-rails', group: :development

# Debug
# rspec test gems
group :staging, :development, :test do
  gem 'tapp'
  gem 'awesome_print'
  gem 'grape-swagger'
  gem 'grape-swagger-rails'
end

# rspec test gems
group :development, :test do
  gem 'rspec-rails', '~>3.1'
  gem 'factory_girl_rails'
  gem 'guard-rspec'
  gem 'database_cleaner'
  gem 'pry-byebug'
  gem 'pry-rails'
  gem 'pry-stack_explorer'
end

group :test do
  gem 'simplecov', '~> 0.9.0', require: false
  gem 'json_expressions'
  gem 'autodoc'
  gem 'webmock'
end

gem 'seed-fu'

group :development do
  # Access an IRB console on exception pages or by using <%= console %> in views
  gem 'web-console', '~> 2.0'

  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring'
  gem 'rubocop', require: false
  gem 'bullet'
  gem 'annotate'
end

# Image uploading
gem 'carrierwave'
gem 'rmagick'
gem 'fog'
gem 'unf'

# Settings
gem 'rails_config'

# API
gem 'grape'
gem 'rabl'
gem 'grape-rabl'
gem 'oj'
gem 'httparty'

gem 'kaminari'
