require "test_helper"

class TwitterServiceTest < ActiveSupport::TestCase
  attr_reader :service

  def setup
    user = OpenStruct.new(oauth_token: ENV["twitter_access_token"],
                          oauth_token_secret: ENV["twitter_access_token_secret"])
    @service = TwitterService.new(user)
  end

  test "#home_timeline" do
    VCR.use_cassette("twitter_service#home_timeline") do
      home_timeline = service.home_timeline
      tweet = home_timeline.first

      assert_equal 0, home_timeline.count
      assert_equal "", tweet.user.name
    end
  end
end
