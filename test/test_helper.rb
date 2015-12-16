ENV['RAILS_ENV'] ||= 'test'
require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'
require 'capybara/rails'
require 'mocha/test_unit'
require 'minitest/pride'
require 'webmock'
require 'vcr'

class ActiveSupport::TestCase
  include FactoryGirl::Syntax::Methods

  VCR.configure do |config|
    config.cassette_library_dir = "test/cassettes"
    config.hook_into :webmock
  end
end

class ActionDispatch::IntegrationTest
  include Capybara::DSL
end
