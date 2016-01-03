ENV["RAILS_ENV"] ||= 'test'
require File.expand_path("../../config/environment", __FILE__)
require 'rspec/rails'
require 'webmock/rspec'
require 'rspec/autorun'
require 'factory_girl'

Dir[Rails.root.join('spec/support/**/*.rb')].each { |f| require f }

ActiveRecord::Migration.check_pending! if defined?(ActiveRecord::Migration)

RSpec.configure do |config|
  config.use_transactional_fixtures = true
  config.infer_base_class_for_anonymous_controllers = false
  config.order = 'random'
  config.include FactoryGirl::Syntax::Methods

  config.before(:suite) do
    DatabaseCleaner.strategy = :truncation
  end
       
  config.before(:each) do
   DatabaseCleaner.start
  end
    
  config.after(:each) do
    DatabaseCleaner.clean
  end

  config.before(:all) do
    FactoryGirl.reload # これがないとfactoryの変更が反映されません
  end

  config.include Requests::JsonHelpers
end
