require "test_helper"

class UserCanSeeNewTweetFormTest < ActionDispatch::IntegrationTest
  def setup
    @user = build_stubbed(:user)
    ApplicationController.any_instance.stubs(:current_user).returns(@user)
  end

  test "user can see new tweet form" do
    VCR.use_cassette("twitter_service#home_timeline") do
      visit "/dashboard"
      click_button "Tweet"

      assert_equal "/tweets/new", current_path
      assert page.has_field? "tweet[text]"
      assert page.has_button? "Submit"
    end
  end
end
