require 'test_helper'

class UserSeesBasicProfileInfoTest < ActionDispatch::IntegrationTest
  def setup
    @user = build_stubbed(:user)
    ApplicationController.any_instance.stubs(:current_user).returns(@user)
  end

  test "user sees basic profile information" do
    VCR.use_cassette("twitter_service#home_timeline") do
      visit "/dashboard"

      within ".user-info" do
        assert page.has_css? ".name", "John Doe"
        assert page.has_css? ".screen-name", "jdoe"
        assert page.has_css? ".tweets", "150"
        assert page.has_css? ".followers", "50"
        assert page.has_css? ".following", "100"
      end
    end
  end
end
