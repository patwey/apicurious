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

  def stub_omniauth
    OmniAuth.config.test_mode = true
    OmniAuth.config.mock_auth[:twitter] = OmniAuth::AuthHash.new({
      provider: "twitter",
      extra: {
        raw_info: {
          user_id: "1234",
          name: "John Doe",
          screen_name: "jdoe",
        }
      },
      credentials: {
        token: ENV["twitter_access_token"],
        secret: ENV["twitter_access_token_secret"]
      }
    })
  end
end
