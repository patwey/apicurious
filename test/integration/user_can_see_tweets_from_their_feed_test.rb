require 'test_helper'

class UserCanSeeTweetsFromTheirFeedTest < ActionDispatch::IntegrationTest
  def setup
    @user = build_stubbed(:user)
    ApplicationController.any_instance.stubs(:current_user).returns(@user)
  end

  test "user can see tweets from their feed" do
    VCR.use_cassette("twitter_service#home_timeline") do
      visit "/dashboard"

      within ".user-timeline" do
        assert page.has_css? ".tweet-user-name", "IRC Intl Rescue Comm"
        assert page.has_css? ".tweet-screen-name", "theIRC"
      end
    end
  end
end
